# Animal data from Video Game Zoo Tycoon

Contains all the data for all animals in base game and expansions.

## Usage

``` r
zoo_tycoon
```

## Format

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with 119 rows and 24 variables.

- name:

  Character, name of animal.

- sci_name:

  Character, scientific name of animal. Will be `NA` for mythical
  creatures.

- biome:

  Character, animal's natural habitat.

- favorite_foliage:

  Character, animal's favorite foliage. 2 values are `NA`.

- location:

  Character, geographical location of origin.

- cost:

  Integer, cost in in-game dollars.

- initial_happiness:

  Integer, initial happiness values. Takes values between 10 and 90.

- min_suitability:

  Integer, Animals get a happiness penalty if their exhibit suitability
  score is lower than this number,

- climbs_fences:

  Character, Whether the animal can climb fences, takes values `"No"`
  and `"Yes"`.

- jumps_fences:

  Character, Whether the animal can jump fences, takes values `"No"` and
  `"Yes"`.

- diet:

  Character, what food the animal eats.

- shelters:

  Character, comma seperated names of shelters the animal likes.

- minimum_social_group:

  Integer, minimum social group.

- animal_density:

  Numeric, animal density.

- adult_attractiv:

  Integer, attractiveness of adult animals, the higher this number, the
  more popular the animal is with guests.

- young_attractiv:

  Integer, attractiveness of young animals, the higher this number, the
  more popular the animal is with guests.

- lifespan:

  Numeric, lifespan in months.

- death_chance:

  Numeric, death chance, mechanics unknown.

- puberty:

  Numeric, puberty length in months.

- reproduction_threshold:

  Integer, threshold based on happiness on whether the animal will
  reproduce.

- reproduction_chance:

  Character, chance of a successful breeding, takes values `"High"`, and
  `"Low"`.

- reproduction_interval:

  Numeric, time between reproduction attempts, in months.

- number_of_offspring:

  Integer, number of offspring or eggs produced.

- expansion:

  Character, name of expansion where animal is from.

## Source

<https://zootycoon.fandom.com/wiki/Main_Page>
