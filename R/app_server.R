#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # Load the modules
  # callModule(mod_first_page_server_1, "id_fec")
  database_path <- golem::get_golem_options("db_path")
  mod_first_page_server("mod_first_page", db_path = database_path)
}
