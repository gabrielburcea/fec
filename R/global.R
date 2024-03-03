#' Teaching levels
#'
#' A character vector with the teaching levels available.
"teaching_levels"

# this prevents global variable notes during devtools::check()
utils::globalVariables(
  c(
  "age",
  "con",
  "confirm_error",
  "db_path",
  "form",
  "level",
  "teaching_levels"
  )
)
