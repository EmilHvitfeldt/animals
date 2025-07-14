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
