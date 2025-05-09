
<!-- README.md is generated from README.Rmd. Please edit that file -->

# animals <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->

<!-- badges: end -->

The goal of animals is to provide a small dataset for text
classification and regression tasks.

## Installation

You can install the package with:

``` r
# install.packages("devtools")
devtools::install_github("EmilHvitfeldt/animals")
```

This package will most likely never be put on CRAN.

## Example

``` r
library(animals)
library(tibble)
glimpse(animals)
#> Rows: 610
#> Columns: 4
#> $ text        <chr> "Aardvark Classification and Evolution\nAardvarks are smal…
#> $ diet        <chr> "Omnivore", "Unknown", "Carnivore", "Unknown", "Unknown", …
#> $ lifestyle   <chr> "Nocturnal", NA, "Diurnal", NA, NA, "Diurnal", "Nocturnal"…
#> $ mean_weight <dbl> 70.0000, NA, 4.5000, NA, NA, 4500.0000, 2.9500, 0.1225, 19…
```
