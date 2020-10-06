## code to prepare `animals` dataset goes here

library(animals)
library(dplyr)
library(stringr)

animals <- animals_raw %>%
  mutate(diet = case_when(
    str_detect(diet, "^Carn") ~ "Carnivore",
    str_detect(diet, "erb") ~ "Herbivore",
    diet == "Nuts, seeds, and fruit" ~ "Herbivore",
    diet == "Plants, roots and small insects" ~ "Herbivore",
    str_detect(diet, "^Om") ~ "Omnivore",
    TRUE ~ "Unknown"
  )) %>%
  select(text, diet, lifestyle)

usethis::use_data(animals, overwrite = TRUE)
