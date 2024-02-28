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
    fluidPage(
      # theme = bslib::bs_theme(version = "5"),
      titlePanel(" "),
      tabsetPanel(
        id = ns("maintabs"),
        type = "hidden",
        tabPanel("page1", {
          tagList(
            div(class = "input-container",
                actionButton(ns("next2"), "Start",
                             style = "font-size: 35px;
                           color: navy;
                           width: 250px;
                           margin-top: 60px;"), #  style = "font-size: 24px;"
                add_logo()
            )
          )
        }),
        tabPanel("page2", {
          tagList(
            div(class = "input-container",
                tags$p(class = "details-text", "Your Details:"),
                textInput(ns("name"), label = NULL, placeholder = "Name"),
                textInput(ns("nationality"), label = NULL, placeholder = "Nationality"),
                textInput(ns("age"), label = NULL, value = "", placeholder = "Age"),
                textInput(ns("email"), label = NULL, placeholder = "Email"),
                actionButton(ns("next3"), "Next",
                             style = "font-size: 30px;
                           color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 60px;"), #  style = "font-size: 24px;"
                add_logo()
            ),
            add_back_button(ns("bck1"))
          )
        }),
        tabPanel("page3", {
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
                actionButton(ns("next4"), "Next",
                             style = "font-size: 30px;
                           color: navy;
                           background-color: green;
                           width: 250px;
                           margin-top: 10px;"),
                add_logo()
            ),
            add_back_button(ns("bck2"))
          )
        }),
        tabPanel("page4", {
          tagList(
            div(
              class = "input-container",
              get_all_teachers(id),
              textOutput(ns("text")),
              actionButton(ns("next5"), "Next",
                           style = "font-size: 30px;
                     color: navy;
                     background-color: green;
                     width: 250px; margin-top: 10px;"),
              add_logo(),
            ),
            add_back_button(ns("bck3"))
          )
        }),
        tabPanel("page5", {
          div(class = "input-container",
              htmlOutput(ns("selection")),
              actionButton(ns("confirm"), "Confirm",
                           style = "font-size: 30px;
                     color: navy;
                     background-color: green;
                     width: 250px; margin-top: 10px;"),
              add_back_button(ns("bck4")),
              add_logo()
          )
        })
      ),
      add_logo()
    )
  )
}

#' mod_first_page_server Server Functions
#'
#' @noRd
mod_first_page_server <- function(id_fec){
  moduleServer(id_fec, function(input, output, session){
    ns <- session$ns

    image_folder <- app_sys("app/www/teachers")
    teachers <- gsub(".png", "", list.files(image_folder, pattern = ".png"))

    go_to_page <- function(page, id = "maintabs"){
      updateTabsetPanel(session = session, inputId = id, selected = page)
    }

    observeEvent(input$next2, { go_to_page("page2") })
    observeEvent(input$next3, { go_to_page("page3") })
    observeEvent(input$next4, { go_to_page("page4") })
    observeEvent(input$next5, { go_to_page("page5") })

    observeEvent(input$bck1, { go_to_page("page1") })
    observeEvent(input$bck2, { go_to_page("page2") })
    observeEvent(input$bck3, { go_to_page("page3") })
    observeEvent(input$bck4, { go_to_page("page4") })

    english_level <- reactiveVal("Not sure")
    observeEvent(input$basicButton, english_level("Basic") )
    observeEvent(input$intermediateButton, english_level("Intermediate"))
    observeEvent(input$intermediatePlusButton, english_level("Intermediate+"))
    observeEvent(input$notSureButton, english_level("Not sure"))

    selected_teacher <- reactiveVal()
    lapply(teachers, \(x){
      shinyjs::onclick(id = paste0("circle_", simplify_string(x)), {
        selected_teacher(x)
        go_to_page("page5")
      }
      )
    })

    output_label <- reactive({
      bslib::card(
        HTML("<br>"),
        tags$h1(input$name),
        tags$h3(paste0("Level: ", english_level())),
        tags$h3(paste0("Teacher: ", selected_teacher())),
        class = "card_custom"
      )
    })

    output$selection <- renderUI({
      output_label()
    })

  })
}

## To be copied in the UI
# mod_mod_first_page_ui("mod_first_page_1")

## To be copied in the server
# mod_mod_first_page_server("mod_first_page_1")

add_back_button <- function(id){
  div(id = "corner-triangle",
      actionButton(label="Back", inputId = id,
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
                   outline: none;"))
}

get_all_teachers <- function(id){
  ns <- NS(id)
  image_folder <- app_sys("app/www/teachers")
  teachers <- gsub(".png", "", list.files(image_folder, pattern = ".png"))
  image_paths <- paste0("www/teachers/", list.files(image_folder, pattern = ".png"))
  names(image_paths) <- teachers

  all_items <- lapply(teachers, \(x){
    bslib::layout_columns(
      col_widths = 12,
      id = ns(paste0("circle_", simplify_string(x))),
      bslib::card_body(
        fillable = FALSE,
        img(src = image_paths[[x]], width = 80, height = 80) |>
          htmltools::tagAppendAttributes(class = "circle"),
        div(x, class = "details-teachers")
      )
    )
  })
  all_items[["width"]] <- "150px"
  do.call(bslib::layout_column_wrap, all_items )
}

add_logo <- function(path = "www/free_english_logo.png"){
  tags$img(src=path, class = "logo", width = "400px")
}
