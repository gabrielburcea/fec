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
    uiOutput(ns("page")))
  )
}

#' mod_first_page_server Server Functions
#'
#' @noRd
mod_first_page_server <- function(id_fec){
  moduleServer(id_fec, function(input, output, session){
    ns <- session$ns
    output$page <- renderUI({
      if (is.null(input$currentPage)) {
        tagList(
          div(class = "input-container",
              actionButton(ns("startButton"), "Start",
                           style = "font-size: 35px;
                           color: navy;
                           width: 250px;
                           margin-top: 60px;") #  style = "font-size: 24px;"
          ),
          tags$img(src = "www/free_english_logo.png", class = "logo", width = "400px") # Adjust the width of the logo
        )
      } else if (input$currentPage == "page2") {
        tagList(
          div(class = "input-container",
              tags$p(class = "details-text", "Your Details:"),
              textInput(ns("name"), label = NULL, placeholder = "Name", style = "background-color: lightblue; color: navy;"),
              textInput(ns("nationality"), label = NULL, placeholder = "Nationality", style = "background-color: lightyellow; color: navy;"),
              textInput(ns("age"), label = NULL, value = "", placeholder = "Age", style = "background-color: lightgreen; color: navy;"),
              textInput(ns("email"), label = NULL, placeholder = "Email", style = "background-color: lightgray; color: navy;"),
              actionButton(ns("nextButton"), "Next",
                           style = "font-size: 30px;
                           color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 60px;") #  style = "font-size: 24px;"
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = ns("bck1"),
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
              actionButton(ns("basicButton"), "Basic"),
              actionButton(ns("intermediateButton"), "Intermediate"),
              actionButton(ns("intermediatePlusButton"), "Intermediate +"),
              actionButton(ns("notSureButton"), "Not sure"),
              actionButton(ns("nextButtonPage3"), "Next",
                           style = "font-size: 30px; color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 60px;") #  style = "font-size: 24px;"
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = ns("bck2"),
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
              textInput(ns("name"), label = NULL, placeholder = "Name"),
              textInput(ns("nationality"), label = NULL, placeholder = "Nationality"),
              textInput(ns("age"), label = NULL, value = "", placeholder = "Age"),
              textInput(ns("email"), label = NULL, placeholder = "Email"),
              actionButton(ns("nextButton"), "Next",
                           style = "font-size: 30px;
                           color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 60px;")
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = ns("bck2"),
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
              actionButton(ns("basicButton"), "Basic",
                           style = "background-color: lightblue;
                           color: navy;
                           margin-top: 0.5px;"),
              actionButton(ns("intermediateButton"), "Intermediate",
                           style = "background-color: lightyellow;
                           color: navy;
                           margin-top: 0.5px;"),
              actionButton(ns("intermediatePlusButton"), "Intermediate +",
                           style = "background-color: lightgreen;
                           color: navy;
                           margin-top: 0.5px;"),
              actionButton(ns("notSureButton"), "Not sure",
                           style = "
                           background-color: lightgray; color: navy;
                           # width: 300px;
                           margin-top: 30px;"
                           ),
              actionButton(ns("nextButtonPage3"), "Next",
                           style = "font-size: 30px;
                           color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 10px;") #
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = ns("bck2"),
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
            actionButton(ns("startButton"), "Start",
                         style = "font-size: 35px;
                         color: navy;
                         width: 250px;
                         margin-top: 60px;")
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
              textInput(ns("name"), label = NULL, placeholder = "Name"),
              textInput(ns("nationality"), label = NULL, placeholder = "Nationality"),
              textInput(ns("age"), label = NULL, value = "", placeholder = "Age"),
              textInput(ns("email"), label = NULL, placeholder = "Email"),
              actionButton(ns("nextButton"), "Next",
                           style = "font-size: 24px;
                           color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 60px;")
          ),
          div(id = "corner-triangle",
              actionButton(label="Back", inputId = ns("bck1"),
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
