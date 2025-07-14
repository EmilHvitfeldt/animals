## code to prepare `zoo_tycoon` dataset goes here
library(tidyverse)
library(httr2)
library(rvest)
library(fs)

## Download all pages ----------------------------------------------------------

req <- request("https://zootycoon.fandom.com/wiki/Warthog")

body <- req |>
  req_perform() |>
  resp_body_html()

all_urls <- body |>
  html_element("table.nav-table") |>
  html_elements("td a") |>
  html_attr("href")

base_url <- "https://zootycoon.fandom.com"

all_urls <- paste0(base_url, all_urls)

if (!dir_exists("data-raw/raw-zootycoon")) {
  dir_create("data-raw/raw-zootycoon")
}

walk(
  all_urls,
  slowly(\(x) download.file(x, paste0("data-raw/raw-zootycoon/", basename(x))))
)

#3 Parse data ------------------------------------------------------------------

all_pages <- dir_ls("data-raw/raw-zootycoon/")

get_data <- function(url) {
  body <- read_html(url)

  val_title <- body |>
    html_element("h2.pi-item") |>
    html_text()
  val_sciname <- body |>
    html_element("nav.pi-navigation") |>
    html_text()

  metrics <- body |>
    html_elements("div.wds-is-current div.pi-data")

  get_metric <- function(x) {
    name <- x |> html_element("h3") |> html_text()
    value <- x |> html_element("div") |> html_text()
    setNames(tibble(value), name)
  }

  all_metrics <- map(metrics, get_metric)

  last <- which(
    map_lgl(
      all_metrics,
      \(x) {
        x[[1]][[1]] %in%
          c(
            "Zoo Tycoon DS",
            "Zoo Tycoon 2 DS",
            "Zoo Tycoon 2: Marine Mania Mobile",
            "Zoo Tycoon: Ultimate Animal Collection",
            "Zoo Tycoon: The Board Game - New Shores",
            "Zoo Tycoon: The Board Game - Additional Species Pack"
          )
      }
    )
  )

  if (length(last) > 0) {
    all_metrics <- all_metrics[seq(1, last[1] - 1)]
  }

  list_cbind(all_metrics) |>
    mutate(name = val_title, sci_name = val_sciname) |>
    relocate(name, sci_name)
}

all_data_raw <- all_pages |>
  map(get_data) |>
  list_rbind()

## Clean data ------------------------------------------------------------------

clean_standards <- function(x) {
  if_else(
    str_detect(x, "^Standard"),
    str_remove(str_remove(x, "(White|Black).*"), "^Standard"),
    x
  )
}

parse_year_month <- function(x) {
  if_else(
    str_detect(x, "years$"),
    parse_number(x) * 12,
    parse_number(x)
  )
}

zoo_tycoon <- all_data_raw |>
  janitor::clean_names() |>
  mutate(
    number_of_offspring = if_else(
      is.na(number_of_offspring),
      clutch_size,
      number_of_offspring
    )
  ) |>
  select(
    -game,
    -eats_eggs,
    -incubation,
    -clutch_size,
    -unlock,
    -toys,
    -availability
  ) |>
  mutate(
    across(everything(), str_trim),
    across(everything(), str_squish),
    across(everything(), clean_standards),
    expansion = replace_na(expansion, "base game"),
    shelters = if_else(shelters == "No shelter required.", "None", shelters)
  ) |>
  mutate(across(where(is.character), str_trim)) |>
  mutate(
    across(
      c(
        cost,
        initial_happiness,
        min_suitability,
        minimum_social_group,
        animal_density,
        adult_attractiv,
        young_attractiv,
        death_chance,
        reproduction_threshold,
        number_of_offspring
      ),
      parse_number
    ),
    across(
      c(
        cost,
        initial_happiness,
        min_suitability,
        minimum_social_group,
        adult_attractiv,
        young_attractiv,
        reproduction_threshold,
        number_of_offspring
      ),
      as.integer
    ),
    across(
      c(
        lifespan,
        puberty,
        reproduction_interval
      ),
      parse_year_month
    ),
    death_chance = death_chance / 100
  )

usethis::use_data(zoo_tycoon, overwrite = TRUE)
