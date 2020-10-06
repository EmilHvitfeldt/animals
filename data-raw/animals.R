## code to prepare `animals` dataset goes here

library(animals)
library(dplyr)
library(stringr)
library(purrr)


calc_mean <- function(text) {
  if (is.na(text)) return(NA)

  if (str_detect(text, "-")) {
    numbers <- str_split(text, pattern = " +- +")[[1]]
    res <- mean(purrr::map_dbl(numbers, convert2g))
  } else {
    res <- convert2g(text)
  }

  res / 1000
}

convert2g <- function(x) {
  res <- readr::parse_number(x)

  if (str_detect(x, "kg")) {
    res <- res * 1000
  }
  res
}

animals <- animals_raw %>%
  mutate(diet = case_when(
    str_detect(diet, "^Carn") ~ "Carnivore",
    str_detect(diet, "erb") ~ "Herbivore",
    diet == "Nuts, seeds, and fruit" ~ "Herbivore",
    diet == "Plants, roots and small insects" ~ "Herbivore",
    str_detect(diet, "^Om") ~ "Omnivore",
    TRUE ~ "Unknown"
  )) %>%
  mutate(mean_weight = str_remove(weight, "\\(+.*"),
         mean_weight = map_dbl(mean_weight, calc_mean)) %>%
  select(text, diet, lifestyle, mean_weight)

usethis::use_data(animals, overwrite = TRUE)
