## code to prepare `aminals` dataset goes here

library(tidyverse)
library(rvest)

base_url <- "https://a-z-animals.com"
html <- read_html(paste0(base_url, "/animals"))


all_animals <- html %>%
  html_nodes('div[class="az-left-box az-animals-index"]
             div[class="content"]
             div[class="letter"]
             ul li a') %>%
  html_attr("href")

all_links <- paste0(base_url, all_animals)

read_article <- function(x) {
  html <- read_html(x)

  text <- html %>%
    html_nodes('div[id="jump-article"]') %>%
    html_nodes("h2 , p") %>%
    html_text()

  text <- str_subset(text, "^View all ", negate = TRUE)

  table_html <- html %>%
    html_node('table[class="az-facts"]')

  facts_raw <- table_html %>%
    html_nodes('td') %>%
    html_text()

  facts <- facts_raw[facts_raw != ""]

  mat <- t(as.matrix(facts[seq_len(length(facts) / 2) * 2]))
  colnames(mat) <- facts[seq_len(length(facts) / 2) * 2 - 1]

  as_tibble(mat) %>%
    mutate(text = paste0(text[-c(1, 2)], collapse = "\n"))
}

all_articles_raw <- map(all_links, read_article)

all_articles_df <- bind_rows(all_articles_raw)

sorted_names <- sort(map_dbl(all_articles_df, ~sum(!is.na(.x))), decreasing = TRUE)
all_articles_df <- all_articles_df %>%
  select(names(sorted_names[sorted_names > 50]))

data_dict <- tibble(names = names(all_articles_df)) %>%
  separate(names, c("name", "description"), ":") %>%
  mutate(clean_name = janitor::make_clean_names(name))

usethis::use_data(data_dict, overwrite = TRUE)

names(all_articles_df) <- data_dict$clean_name

animals <- all_articles_df

usethis::use_data(animals, overwrite = TRUE)
