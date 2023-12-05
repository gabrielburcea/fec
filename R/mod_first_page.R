#' mod_first_page_ui UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_first_page_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "fec/inst/app/www/styles.css")
    ),
    titlePanel(" "),
    uiOutput("page"))
  )
}

#' mod_first_page_server Server Functions
#'
#' @noRd
mod_first_page_server <- function(id_fec){
  moduleServer(id_fec, function(input, output, session){
    output$page <- renderUI({
      if (is.null(input$currentPage)) {
        tagList(
          div(class = "input-container",
              actionButton(ns("startButton"), "Start", style = "font-size: 35px; color: navy;") #  style = "font-size: 24px;"
          ),
          tags$img(src = "www/free_english_logo.png", class = "logo", width = "400px") # Adjust the width of the logo
        )
      } else if (input$currentPage == "page2") {
        tagList(
          div(class = "input-container",
              tags$p(class = "details-text", "Your Details:"),
              textInput("name", label = NULL, placeholder = "Name", style = "background-color: lightblue; color: navy;"),
              textInput("nationality", label = NULL, placeholder = "Nationality", style = "background-color: lightyellow; color: navy;"),
              textInput("age", label = NULL, value = "", placeholder = "Age", style = "background-color: lightgreen; color: navy;"),
              textInput("email", label = NULL, placeholder = "Email", style = "background-color: lightgray; color: navy;"),
              actionButton("nextButton", "Next", style = "font-size: 30px; color: navy;") #  style = "font-size: 24px;"
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = "bck1",
                           style = "top: -150px;
                                        left: 25px;
                                        font-size: 25px;
                                        position: relative;
                                        transform: rotate(-45deg);
                                        color: navy;
                                        border: none;
                                        background-color: transparent;
                                        font-weight: bold;
                                        padding: 2em;
                                        margin: -2em;
                                        outline: none;")),
          tags$img(src = "www/free_english_logo.png", class = "logo", width = "400px")
        )
      } else if (input$currentPage == "page3") {
        tagList(
          div(class = "input-container",
              tags$p(class = "details-text", "Teaching level:"),
              actionButton("basicButton", "Basic"),
              actionButton("intermediateButton", "Intermediate"),
              actionButton("intermediatePlusButton", "Intermediate +"),
              actionButton("notSureButton", "Not sure"),
              actionButton("nextButtonPage3", "Next", style = "font-size: 30px; color: navy;") #  style = "font-size: 24px;"
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = "bck2",
                           style = "top: -150px;
                                        left: 25px;
                                        font-size: 25px;
                                        position: relative;
                                        transform: rotate(-45deg);
                                        color: navy;
                                        border: none;
                                        background-color: transparent;
                                        font-weight: bold;
                                        padding: 2em;
                                        margin: -2em;
                                        outline: none;")),
          tags$img(src ="www/free_english_logo.png", class = "logo", width = "400px")
        )
      }
    })

    observeEvent(input$startButton, {
      output$page <- renderUI({
        tagList(
          div(class = "input-container",
              tags$p(class = "details-text", "Your Details:"),
              textInput("name", label = NULL, placeholder = "Name"),
              textInput("nationality", label = NULL, placeholder = "Nationality"),
              textInput("age", label = NULL, value = "", placeholder = "Age"),
              textInput("email", label = NULL, placeholder = "Email"),
              actionButton("nextButton", "Next", style = "font-size: 30px; color: navy;")
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = "bck2",
                           style = "top: -150px;
                                        left: 25px;
                                        font-size: 25px;
                                        position: relative;
                                        transform: rotate(-45deg);
                                        color: navy;
                                        border: none;
                                        background-color: transparent;
                                        font-weight: bold;
                                        padding: 2em;
                                        margin: -2em;
                                        outline: none;")),
          tags$img(src = "www/free_english_logo.png", class = "logo", width = "400px")
        )
      })
    })

    observeEvent(input$nextButton, {
      name <- input$name
      nationality <- input$nationality
      age <- input$age
      email <- input$email

      output$page <- renderUI({
        tagList(
          div(class = "input-container",
              tags$p(class = "details-text", "Teaching level:"),
              actionButton("basicButton", "Basic", style = "background-color: lightblue; color: navy;"),
              actionButton("intermediateButton", "Intermediate", style = "background-color: lightyellow; color: navy;"),
              actionButton("intermediatePlusButton", "Intermediate +", style = "background-color: lightgreen; color: navy;"),
              actionButton("notSureButton", "Not sure", style = "background-color: lightgray; color: navy;"),
              actionButton("nextButtonPage3", "Next", style = "font-size: 30px; color: navy;") #
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = "bck2",
                           style = "top: -150px;
                                        left: 25px;
                                        font-size: 25px;
                                        position: relative;
                                        transform: rotate(-45deg);
                                        color: navy;
                                        border: none;
                                        background-color: transparent;
                                        font-weight: bold;
                                        padding: 2em;
                                        margin: -2em;
                                        outline: none;")),
          tags$img(src = "www/free_english_logo.png", class = "logo", width = "400px")
        )
      })
    })
    observeEvent(input$bck1, {
      output$page <- renderUI({
        tagList(
          div(
            class = "input-container",
            actionButton("startButton", "Start", style = "font-size: 35px; color: navy;")
          ),
          tags$img(
            src = "www/free_english_logo.png",
            class = "logo",
            width = "400px"
          ) # Adjust the width of the logo
        )
      })
    })

    observeEvent(input$bck2, {
      output$page <- renderUI({
        tagList(
          div(class = "input-container",
              tags$p(class = "details-text", "Your Details:"),
              textInput("name", label = NULL, placeholder = "Name"),
              textInput("nationality", label = NULL, placeholder = "Nationality"),
              textInput("age", label = NULL, value = "", placeholder = "Age"),
              textInput("email", label = NULL, placeholder = "Email"),
              actionButton("nextButton", "Next", style = "font-size: 24px; color: navy;")
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = "bck1",
                           style = "top: -150px;
                                        left: 25px;
                                        font-size: 25px;
                                        position: relative;
                                        transform: rotate(-45deg);
                                        color: navy;
                                        border: none;
                                        background-color: transparent;
                                        font-weight: bold;
                                        padding: 2em;
                                        margin: -2em;
                                        outline: none;")),
          tags$img(src = "www/free_english_logo.png", class = "logo", width = "400px") # Adjust the width of the logo
        )
      })
    })
  })
}

## To be copied in the UI
# mod_mod_first_page_ui("mod_first_page_1")

## To be copied in the server
# mod_mod_first_page_server("mod_first_page_1")
