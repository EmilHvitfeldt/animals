## code to prepare `lets_build_a_zoo` dataset goes here
library(tidyverse)
library(httr2)
library(fs)

## Download all pages ----------------------------------------------------------

# The wiki blocks plain HTML requests, but the MediaWiki API responds fine with
# a browser user agent. Pages are cached as wikitext since all the data we want
# lives in templates rather than the rendered tables.

base_url <- "https://letsbuildazoo.fandom.com/api.php"

get_wikitext <- function(page) {
  request(base_url) |>
    req_url_query(
      action = "parse",
      page = page,
      prop = "wikitext",
      format = "json"
    ) |>
    req_user_agent("animals R package (https://github.com/EmilHvitfeldt/animals)") |>
    req_perform() |>
    resp_body_json() |>
    pluck("parse", "wikitext", "*")
}

index <- get_wikitext("Animal")

# The index page lists animals in three galleries, one per game/DLC, with each
# entry shaped like `File:Alpaca.png|link=Alpaca|[[Alpaca]]`.
galleries <- index |>
  str_split("<gallery[^>]*>") |>
  pluck(1) |>
  tail(-1) |>
  str_remove("</gallery>.*")

names(galleries) <- c("base game", "Dinosaur Island", "Aquarium Odyssey")

animal_index <- galleries |>
  map(\(x) str_match_all(x, "link=([^|]+)\\|")[[1]][, 2]) |>
  enframe(name = "expansion", value = "name") |>
  unnest(name)

if (!dir_exists("data-raw/raw-letsbuildazoo")) {
  dir_create("data-raw/raw-letsbuildazoo")
}

download_page <- function(page) {
  path <- path("data-raw/raw-letsbuildazoo", str_replace_all(page, " ", "_"), ext = "txt")
  if (file_exists(path)) {
    return(invisible(path))
  }
  write_lines(get_wikitext(page), path)
  invisible(path)
}

walk(animal_index$name, slowly(download_page), .progress = TRUE)

write_csv(animal_index, "data-raw/raw-letsbuildazoo-index.csv")

## Parse data ------------------------------------------------------------------

read_page <- function(name) {
  read_file(path("data-raw/raw-letsbuildazoo", str_replace_all(name, " ", "_"), ext = "txt"))
}

pages <- set_names(map_chr(animal_index$name, read_page), animal_index$name)

# Pull a `{{template | key = value | ... }}` block out of a page. Templates can
# nest (`{{PAGENAME}}` in the infobox, `{{alink|Badger}}` in cohabitation), so
# the closing braces have to be found by tracking nesting depth rather than by
# matching the first `}}`.
extract_block <- function(page, start) {
  rest <- str_sub(page, start)
  braces <- str_locate_all(rest, "\\{\\{|\\}\\}")[[1]]
  depth <- cumsum(if_else(str_sub(rest, braces[, 1], braces[, 2]) == "{{", 1L, -1L))
  str_sub(rest, 1, braces[which(depth == 0L)[1], 2])
}

# Splitting a block on `|` would also split nested templates apart, so their
# pipes are hidden behind a sentinel for the duration of the split.
sentinel <- "\u0001"

get_template <- function(page, template) {
  opening <- regex(paste0("\\{\\{ *", template, "[ \n|]"), ignore_case = TRUE)
  start <- str_locate(page, opening)[, 1]
  if (is.na(start)) {
    return(character(0))
  }

  fields <- extract_block(page, start) |>
    str_remove(regex(paste0("\\{\\{ *", template), ignore_case = TRUE)) |>
    str_remove("\\}\\}$") |>
    str_replace_all("\\{\\{[^{}]*\\}\\}", \(x) str_replace_all(x, "\\|", sentinel)) |>
    str_split_1("\\|") |>
    str_subset("=") |>
    str_replace_all(sentinel, "|")

  set_names(
    str_squish(str_remove(fields, "^[^=]*=")),
    str_squish(str_remove(fields, "=.*"))
  )
}

# Fields are written inconsistently across pages ("198 Days" vs "225 days",
# missing values written as "?"), so everything numeric goes through parse_number.
as_number <- function(x) {
  x[!str_detect(x, "\\d")] <- NA
  parse_number(x)
}

# Like enframe(), but keeps the column types stable for pages where the
# template is missing and get_template() returns nothing.
enframe_fields <- function(x, name, value) {
  tibble(!!name := rlang::names2(x), !!value := as.character(x))
}

infobox <- map(pages, get_template, "Animal")

field <- function(name) {
  map_chr(infobox, \(x) pluck(x, name, .default = NA_character_))
}

lets_build_a_zoo <- tibble(
  name = animal_index$name,
  expansion = animal_index$expansion,
  # The blurb shown in game, stored as a `{{quote|...}}` template, or as a plain
  # `<blockquote>` on a couple of pages.
  description = coalesce(
    str_squish(str_match(pages, regex("\\{\\{quote\\|([^}]*)\\}\\}", ignore_case = TRUE))[, 2]),
    str_squish(str_match(pages, "<blockquote>(.*?)</blockquote>")[, 2])
  ),
  diet = field("diettype"),
  weight = as_number(field("weight")),
  popularity = as_number(field("popularity")),
  lifespan = as_number(field("lifeexpectancy")),
  breed_chance = as_number(field("breedchance")),
  gestation = as_number(field("gestation")),
  floorspace = field("requiredfloorspace")
) |>
  # "20 + 5(N)" means a 20 tile territory plus 5 more tiles per extra animal.
  mutate(
    territory_space = as_number(str_extract(floorspace, "^[^+]+")),
    separation_space = as_number(str_extract(floorspace, "\\+.*")),
    .keep = "unused"
  ) |>
  # A single page misspells the diet type.
  mutate(diet = str_replace(diet, "Herbiore", "Herbivore"))

# Biomes differ between the base game and each DLC (8 apiece, 22 distinct), so
# ratings are kept long rather than as a mostly-empty wide table. Ratings run
# red (worst), yellow, green, heart (best).
lbaz_living_conditions <- pages |>
  map(\(x) {
    c(
      get_template(x, "living conditions"),
      get_template(x, "aquatic living conditions"),
      get_template(x, "dinosaur living conditions")
    )
  }) |>
  map(\(x) enframe_fields(x, "biome", "rating")) |>
  list_rbind(names_to = "name") |>
  mutate(rating = tolower(rating)) |>
  filter(rating %in% c("red", "yellow", "green", "heart"))

# Cohabitation is a directed relation: an animal can be threatening to a species
# that is not threatening to it. Pages with "Unknown" or an empty template
# contribute no rows.
lbaz_cohabitation <- pages |>
  map(\(x) enframe_fields(get_template(x, "cohabitation"), "relation", "other")) |>
  list_rbind(names_to = "name") |>
  filter(relation %in% c("threatening to", "threatened by", "cohabitate with")) |>
  mutate(other = str_match_all(other, "\\{\\{alink\\|([^|}]+)")) |>
  mutate(other = map(other, \(x) str_squish(x[, 2]))) |>
  unnest(other)

usethis::use_data(lets_build_a_zoo, overwrite = TRUE)
usethis::use_data(lbaz_living_conditions, overwrite = TRUE)
usethis::use_data(lbaz_cohabitation, overwrite = TRUE)
