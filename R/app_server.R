#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # Load the modules
  # callModule(mod_first_page_server_1, "id_fec")
  mod_first_page_server("mod_first_page_1")
}
