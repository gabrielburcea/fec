library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: navy; /* Set background color for the body */
      }
      .input-container {
        width: 80%;
        text-align: center;
        background-color: navy; /* Set background color for the input container */
        padding: 20px; /* Add padding for better visibility */
      }
      .input-container input[type='text'],
      .input-container input[type='number'],
      .input-container .btn {
        width: 100%;
        padding: 15px;
        margin: 5px 0;
        box-sizing: border-box;
        font-size: 18px;
        text-align: center;
      }
      .input-container .btn {
        margin-top: 20px;
      }
      .details-text {
        color: white; /* Set the text color to white */
        font-size: 20px;
        margin-bottom: 10px;
        text-align: center; /* Align text to the center */
      }
    "))
  ),
  titlePanel(" "),
  uiOutput("page")
)

server <- function(input, output, session) {
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

shinyApp(ui, server)
