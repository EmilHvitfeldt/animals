# Animal data from Video Game Let's Build a Zoo

Each row is an animal that can be kept in the zoo management game Let's
Build a Zoo, covering the base game and the Dinosaur Island and Aquarium
Odyssey DLCs. Spliced hybrid animals are not included.

## Usage

``` r
lets_build_a_zoo
```

## Format

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with 164 rows and 11 variables.

- name:

  Character, name of animal. Unique.

- expansion:

  Character, which release the animal comes from. Takes values
  `"base game"` (63 animals), `"Dinosaur Island"` (51) and
  `"Aquarium Odyssey"` (50). Determines which biomes the animal is rated
  against in
  [lbaz_living_conditions](https://emilhvitfeldt.github.io/animals/reference/lbaz_living_conditions.md).

- description:

  Character, the blurb shown for the animal in game. Between 55 and 325
  characters.

- diet:

  Character, takes values `"Carnivore"` (73), `"Herbivore"` (58),
  `"Omnivore"` (32) and `"Insectivore"` (1).

- weight:

  Numeric, weight of an adult in kilograms. Spans five orders of
  magnitude, from 1 kg up to the blue whale at 100,000 kg, so a log
  scale is usually wanted when plotting.

- popularity:

  Numeric, percentage popularity with guests, between 20 and 100. Only
  recorded for base game animals: every DLC page leaves it blank, so 104
  of the 164 rows are `NA`.

- lifespan:

  Numeric, life expectancy in in-game days, between 30 and 510.

- breed_chance:

  Numeric, percentage chance of a successful breeding, between 5 and 50.

- gestation:

  Numeric, gestation length in in-game days. Only 9 distinct values,
  between 2 and 10.

- territory_space:

  Numeric, tiles of enclosure needed for the first animal, between 4 and
  60.

- separation_space:

  Numeric, additional tiles needed per further animal, between 1 and 20.

## Source

<https://letsbuildazoo.fandom.com/wiki/Animal>

## See also

[lbaz_living_conditions](https://emilhvitfeldt.github.io/animals/reference/lbaz_living_conditions.md),
[lbaz_cohabitation](https://emilhvitfeldt.github.io/animals/reference/lbaz_cohabitation.md)
