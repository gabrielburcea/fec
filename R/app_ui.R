#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  tagList(
    golem_add_external_resources(),
    # Create a tag to reference the CSS file
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "www/custom.css")
    ),

    mainPanel(
      div(
        id = "main-page",
        align = "center",
        actionButton(inputId = "start-button", label = "START")
      )
    )
  )

}


#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "fec"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
