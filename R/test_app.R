library(shiny)

ui <- fluidPage(
  # Link the style.css file to the HTML head section
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "www/style.css")
  ),

  mainPanel(
    tags$style("text-align: center;"),

    actionButton("startButton", "START", class = "startButton")
  )
)

server <- function(input, output) {
  # Render the user information form when the start button is clicked
  output$userInformationForm <- renderUI({
    if (input$startButton) {
      fluidPage(
        titlePanel("User Information Form"),
        mainPanel(
          form(
            textInput("name", label = "NAME"),
            textInput("nationality", label = "NATIONALITY"),
            numericInput("age", label = "AGE"),
            textInput("email", label = "EMAIL"),
            actionButton("submitButton", "SUBMIT")
          )
        )
      )
    } else {
      NULL
    }
  })
}

shinyApp(ui = ui, server = server)
