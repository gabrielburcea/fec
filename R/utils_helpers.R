#' helpers
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd

#' Simplify String
#'
#' Converts readable names to clean ids that are easier to handle in R.
#' Replaces all punctuation and spaces for an underscore, and transforms all
#' uppercase letters to lowercase.
#'
#' @param x a character vector or a factor. Factors will be silently converted
#' to character strings.
#'
#' @return character vector of the same length as the input vector.
#' @export
#'
#' @examples simplify_string(c(" Dirty_name. to Clean.#$", "#$another   complicated. Name"))
simplify_string <- function(x){
  if(is.factor(x)) x <- as.character(x)
  stopifnot(is.vector(x))
  stopifnot("character" %in% class(x))
  x <- tolower(trimws(gsub("[[:punct:]]+", " ", x)))
  gsub(" +", "_", x)
}
