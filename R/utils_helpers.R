
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


#' Connect to database
#'
#' Small helper function to connect to database. It will disconnect
#' automatically outside of the used environment.
#'
#' @param path Character vector. Path to the database.
#' @param drv Database driver to use. Defaults to `RSQLite::SQLite()`.
#' @param envir Environment to make the connection available in.
#'
#' @return A database connection.
#' @export
#'
#' @examples get_db_connection(tempfile(fileext = ".sqlite"))
get_db_connection <- function(
    path = db_path,
    drv = RSQLite::SQLite(),
    envir = parent.frame()
){
  withr::local_db_connection(
    DBI::dbConnect(drv, path),
    .local_envir =  envir
  )
}


#' Collect teacher data
#'
#' Collect teacher data from the database.
#'
#' @param db_path Path to the database.
#'
#' @return A data frame.
#' @export
#'
get_teacher_table <- function(
    db_path = app_sys("fec_data.sqlite")
    ){
  stopifnot(file.exists(db_path))
  DBI::dbGetQuery(get_db_connection(db_path), "SELECT * from teacher_info")
}

#' Collect student data
#'
#' Collect student data from the database
#'
#' @param db_path Path to the database.
#'
#' @return A data frame.
#' @export
#'
get_student_table <- function(
    db_path = app_sys("fec_data.sqlite")
){
  stopifnot(file.exists(db_path))
  DBI::dbGetQuery(get_db_connection(db_path), "SELECT * from student_info")
}
