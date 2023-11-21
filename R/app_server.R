#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  output$page <- renderUI({
    if (is.null(input$currentPage)) {
      tagList(
        div(class = "input-container",
            actionButton("startButton", label = "START", style = "font-size: 24px;")
        )
      )
    } else if (input$currentPage == "page2") {
      tagList(
        div(class = "input-container",
            tags$p(class = "details-text", "Your Details:"),
            textInput("name", label = NULL, placeholder = "NAME"),
            textInput("nationality", label = NULL, placeholder = "NATIONALITY"),
            textInput("age", label = NULL, value = "", placeholder = "AGE"),
            textInput("email", label = NULL, placeholder = "EMAIL"),
            actionButton("nextButton", "NEXT", style = "font-size: 24px;")
        )
      )
    }
  })

  observeEvent(input$startButton, {
    output$page <- renderUI({
      updateTextInput(session, "name", value = "")
      updateTextInput(session, "nationality", value = "")
      updateTextInput(session, "age", value = "")
      updateTextInput(session, "email", value = "")

      tagList(
        div(class = "input-container",
            tags$p(class = "details-text", "Your Details:"),
            textInput("name", label = NULL, placeholder = "NAME"),
            textInput("nationality", label = NULL, placeholder = "NATIONALITY"),
            textInput("age", label = NULL, value = "", placeholder = "AGE"),
            textInput("email", label = NULL, placeholder = "EMAIL"),
            actionButton("nextButton", "NEXT", style = "font-size: 24px;")
        )
      )
    })
  })

  observeEvent(input$nextButton, {
    name <- input$name
    nationality <- input$nationality
    age <- input$age
    email <- input$email

    # Save data to CSV
    student_data <- data.frame(Name = name, Nationality = nationality, Age = age, Email = email)
    write.csv(student_data, "data-raw/student_data.csv", append = TRUE, row.names = FALSE)
  })

}
