# Let's Build a Zoo cohabitation

Which animals in
[lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md)
can safely share an exhibit, one row per directed pair. The relation is
directed: an animal can be threatening to a species that is not
threatening to it.

## Usage

``` r
lbaz_cohabitation
```

## Format

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with 3957 rows and 3 variables.

- name:

  Character, the animal the relation is stated from, as in
  [lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md).

- relation:

  Character, how `name` relates to `other`. Takes values
  `"cohabitate with"` (1,835 rows), `"threatening to"` (1,062) and
  `"threatened by"` (1,060). `name` is the subject, so
  `"threatening to"` means `name` threatens `other`.

- other:

  Character, the other animal in the pair. Every value is a name in
  [lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md).

## Source

<https://letsbuildazoo.fandom.com/wiki/Animal>

## Details

Coverage is uneven. Only the 80 animals whose page records cohabitation
are included, and 3,906 of the 3957 rows come from base game animals, 51
from Dinosaur Island, and none from Aquarium Odyssey.

## See also

[lets_build_a_zoo](https://emilhvitfeldt.github.io/animals/reference/lets_build_a_zoo.md),
[lbaz_living_conditions](https://emilhvitfeldt.github.io/animals/reference/lbaz_living_conditions.md)
