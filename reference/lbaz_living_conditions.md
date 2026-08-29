# Let's Build a Zoo living conditions

How suitable each biome is for each animal in
[lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md),
one row per animal-biome pair. Stored in long form because the base game
and the two DLCs each use their own set of biomes, 22 distinct in total,
so a wide table would be mostly empty.

## Usage

``` r
lbaz_living_conditions
```

## Format

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with 1250 rows and 3 variables.

- name:

  Character, name of animal, as in
  [lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md).

- biome:

  Character, the terrain the enclosure is built from. The base game uses
  `"arctic"`, `"concrete"`, `"desert"`, `"forest"`, `"grass"`,
  `"mountain"`, `"savannah"` and `"tropical"`; Dinosaur Island uses
  `"cage"`, `"electric"`, `"glass"`, `"grassland"`, `"jungle"`,
  `"marsh"`, `"volcanic"` and `"arctic"` again; Aquarium Odyssey uses
  `"coastal"`, `"cold water"`, `"deepsea"`, `"freshwater"`,
  `"open ocean"`, `"reefs"` and `"saltwater"`.

- rating:

  Character, how well the animal does in the biome. Takes values `"red"`
  (worst, 728 rows), `"yellow"` (299), `"green"` (59) and `"heart"`
  (best, 164). Every animal has exactly one `"heart"` biome, its ideal
  habitat.

## Source

<https://letsbuildazoo.fandom.com/wiki/Animal>

## Details

All 164 animals appear, but 62 individual ratings are blank on the wiki
and so are absent here: 114 animals have 8 rows, 48 have 7, and 2 have a
single row.

## See also

[lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md),
[lbaz_cohabitation](https://emilhvitfeldt.github.io/animals/reference/lbaz_cohabitation.md)
