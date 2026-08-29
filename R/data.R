#' Raw  Animal description dataset
#'
#' @source \url{https://a-z-animals.com/}
#'
#' @format A [tibble][tibble::tibble-package] with 610 rows and 48 variables.
"animals_raw"

#' Cleaned Animal description dataset
#'
#' @source \url{https://a-z-animals.com/}
#'
#' @format A [tibble][tibble::tibble-package] with 610 rows and `r ncol(animals)` variables.
"animals"

#' Animals dataset data dictionary
#'
#' @source \url{https://a-z-animals.com/}
#'
#' @format A [tibble][tibble::tibble-package] with 48 rows and 3 variables.
"data_dict"

#' Animal data from Video Game Zoo Tycoon
#' 
#' Contains all the data for all animals in base game and expansions.
#'
#' @source \url{https://zootycoon.fandom.com/wiki/Main_Page}
#'
#' @format A [tibble][tibble::tibble-package] with `r nrow(zoo_tycoon)` rows and
#'   `r ncol(zoo_tycoon)` variables.
#' 
#' \describe{
#'   \item{name}{Character, name of animal.}
#'   \item{sci_name}{Character, scientific name of animal. Will be `NA` for 
#'   mythical creatures.}
#'   \item{biome}{Character, animal's natural habitat.}
#'   \item{favorite_foliage}{Character, animal's favorite foliage. 2 values are 
#'   `NA`.}
#'   \item{location}{Character, geographical location of origin.}
#'   \item{cost}{Integer, cost in in-game dollars.}
#'   \item{initial_happiness}{Integer, initial happiness values. Takes values
#'   between 10 and 90.}
#'   \item{min_suitability}{Integer, Animals get a happiness penalty if their 
#'   exhibit suitability score is lower than this number, }
#'   \item{climbs_fences}{Character, Whether the animal can climb fences, takes 
#'   values `"No"` and `"Yes"`.}
#'   \item{jumps_fences}{Character, Whether the animal can jump fences, takes 
#'   values `"No"` and `"Yes"`.}
#'   \item{diet}{Character, what food the animal eats.}
#'   \item{shelters}{Character, comma seperated names of shelters the animal
#'   likes.}
#'   \item{minimum_social_group}{Integer, minimum social group.}
#'   \item{animal_density}{Numeric, animal density.}
#'   \item{adult_attractiv}{Integer, attractiveness of adult animals, the higher
#'   this number, the more popular the animal is with guests.}
#'   \item{young_attractiv}{Integer, attractiveness of young animals, the higher
#'   this number, the more popular the animal is with guests.}
#'   \item{lifespan}{Numeric, lifespan in months.}
#'   \item{death_chance}{Numeric, death chance, mechanics unknown.}
#'   \item{puberty}{Numeric, puberty length in months.}
#'   \item{reproduction_threshold}{Integer, threshold based on happiness on 
#'   whether the animal will reproduce.}
#'   \item{reproduction_chance}{Character, chance of a successful breeding, 
#'   takes values `"High"`, and `"Low"`.}
#'   \item{reproduction_interval}{Numeric, time between reproduction attempts,
#'   in months.}
#'   \item{number_of_offspring}{Integer, number of offspring or eggs produced.}
#'   \item{expansion}{Character, name of expansion where animal is from.}
#' }
"zoo_tycoon"

#' Animal data from Video Game Let's Build a Zoo
#'
#' Each row is an animal that can be kept in the zoo management game Let's
#' Build a Zoo, covering the base game and the Dinosaur Island and Aquarium
#' Odyssey DLCs. Spliced hybrid animals are not included.
#'
#' @source \url{https://letsbuildazoo.fandom.com/wiki/Animal}
#'
#' @format A [tibble][tibble::tibble-package] with `r nrow(lets_build_a_zoo)`
#'   rows and `r ncol(lets_build_a_zoo)` variables.
#'
#' \describe{
#'   \item{name}{Character, name of animal. Unique.}
#'   \item{expansion}{Character, which release the animal comes from. Takes
#'   values `"base game"` (63 animals), `"Dinosaur Island"` (51) and
#'   `"Aquarium Odyssey"` (50). Determines which biomes the animal is rated
#'   against in [lbaz_living_conditions].}
#'   \item{description}{Character, the blurb shown for the animal in game.
#'   Between 55 and 325 characters.}
#'   \item{diet}{Character, takes values `"Carnivore"` (73), `"Herbivore"`
#'   (58), `"Omnivore"` (32) and `"Insectivore"` (1).}
#'   \item{weight}{Numeric, weight of an adult in kilograms. Spans five orders
#'   of magnitude, from 1 kg up to the blue whale at 100,000 kg, so a log
#'   scale is usually wanted when plotting.}
#'   \item{popularity}{Numeric, percentage popularity with guests, between 20
#'   and 100. Only recorded for base game animals: every DLC page leaves it
#'   blank, so 104 of the `r nrow(lets_build_a_zoo)` rows are `NA`.}
#'   \item{lifespan}{Numeric, life expectancy in in-game days, between 30 and
#'   510.}
#'   \item{breed_chance}{Numeric, percentage chance of a successful breeding,
#'   between 5 and 50.}
#'   \item{gestation}{Numeric, gestation length in in-game days. Only 9
#'   distinct values, between 2 and 10.}
#'   \item{territory_space}{Numeric, tiles of enclosure needed for the first
#'   animal, between 4 and 60.}
#'   \item{separation_space}{Numeric, additional tiles needed per further
#'   animal, between 1 and 20.}
#' }
#'
#' @seealso [lbaz_living_conditions], [lbaz_cohabitation]
"lets_build_a_zoo"

#' Let's Build a Zoo living conditions
#'
#' How suitable each biome is for each animal in [lets_build_a_zoo], one row
#' per animal-biome pair. Stored in long form because the base game and the
#' two DLCs each use their own set of biomes, 22 distinct in total, so a wide
#' table would be mostly empty.
#'
#' All `r nrow(lets_build_a_zoo)` animals appear, but 62 individual ratings
#' are blank on the wiki and so are absent here: 114 animals have 8 rows, 48
#' have 7, and 2 have a single row.
#'
#' @source \url{https://letsbuildazoo.fandom.com/wiki/Animal}
#'
#' @format A [tibble][tibble::tibble-package] with
#'   `r nrow(lbaz_living_conditions)` rows and
#'   `r ncol(lbaz_living_conditions)` variables.
#'
#' \describe{
#'   \item{name}{Character, name of animal, as in [lets_build_a_zoo].}
#'   \item{biome}{Character, the terrain the enclosure is built from. The base
#'   game uses `"arctic"`, `"concrete"`, `"desert"`, `"forest"`, `"grass"`,
#'   `"mountain"`, `"savannah"` and `"tropical"`; Dinosaur Island uses
#'   `"cage"`, `"electric"`, `"glass"`, `"grassland"`, `"jungle"`, `"marsh"`,
#'   `"volcanic"` and `"arctic"` again; Aquarium Odyssey uses `"coastal"`,
#'   `"cold water"`, `"deepsea"`, `"freshwater"`, `"open ocean"`, `"reefs"`
#'   and `"saltwater"`.}
#'   \item{rating}{Character, how well the animal does in the biome. Takes
#'   values `"red"` (worst, 728 rows), `"yellow"` (299), `"green"` (59) and
#'   `"heart"` (best, 164). Every animal has exactly one `"heart"` biome, its
#'   ideal habitat.}
#' }
#'
#' @seealso [lets_build_a_zoo], [lbaz_cohabitation]
"lbaz_living_conditions"

#' Let's Build a Zoo cohabitation
#'
#' Which animals in [lets_build_a_zoo] can safely share an exhibit, one row
#' per directed pair. The relation is directed: an animal can be threatening
#' to a species that is not threatening to it.
#'
#' Coverage is uneven. Only the `r length(unique(lbaz_cohabitation$name))`
#' animals whose page records cohabitation are included, and 3,906 of the
#' `r nrow(lbaz_cohabitation)` rows come from base game animals, 51 from
#' Dinosaur Island, and none from Aquarium Odyssey.
#'
#' @source \url{https://letsbuildazoo.fandom.com/wiki/Animal}
#'
#' @format A [tibble][tibble::tibble-package] with
#'   `r nrow(lbaz_cohabitation)` rows and `r ncol(lbaz_cohabitation)`
#'   variables.
#'
#' \describe{
#'   \item{name}{Character, the animal the relation is stated from, as in
#'   [lets_build_a_zoo].}
#'   \item{relation}{Character, how `name` relates to `other`. Takes values
#'   `"cohabitate with"` (1,835 rows), `"threatening to"` (1,062) and
#'   `"threatened by"` (1,060). `name` is the subject, so `"threatening to"`
#'   means `name` threatens `other`.}
#'   \item{other}{Character, the other animal in the pair. Every value is a
#'   name in [lets_build_a_zoo].}
#' }
#'
#' @seealso [lets_build_a_zoo], [lbaz_living_conditions]
"lbaz_cohabitation"
