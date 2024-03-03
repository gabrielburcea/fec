#' mod_first_page_ui UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom htmltools htmlEscape
#'
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
                add_logo()
            ),
            add_back_button(ns("bck2"))
          )
        }),
        tabPanel("page4", {
          tagList(
            div(
              class = "input-container",
              uiOutput(ns("teachers")),
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
              htmlOutput(ns("confirm_error")) |> tagAppendAttributes(class = "details-text"),
              add_back_button(ns("bck4")),
              add_logo()
          )
        }),
        tabPanel("page6", {
          div(class = "input-container",
              div("Please take your sticker and join the queue.", class = "details-text"),
              div(id = ns("start_over"), icon("rotate-right"), class = "repeat_icon"),
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
mod_first_page_server <- function(id, db_path){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    image_folder <- app_sys("app/www/teachers")
    stopifnot("Database not found" = file.exists(db_path))

    con <- get_db_connection(db_path)
    teachers <- DBI::dbGetQuery(con, "SELECT teacher FROM teacher_info;") |>
      unlist(use.names = FALSE)

    go_to_page <- function(page, id = "maintabs"){
      updateTabsetPanel(session = session, inputId = id, selected = page)
    }

    observeEvent(input$next2, { go_to_page("page2") })
    observeEvent(input$next3, { go_to_page("page3") })

    observeEvent(input$bck1, { go_to_page("page1") })
    observeEvent(input$bck2, { go_to_page("page2") })
    observeEvent(input$bck3, { go_to_page("page3") })
    observeEvent(input$bck4, { go_to_page("page4") })

    english_level <- reactiveVal("Not sure")
    observeEvent(input$basicButton, { english_level("Basic"); go_to_page("page4") })
    observeEvent(input$intermediateButton, { english_level("Intermediate"); go_to_page("page4")})
    observeEvent(input$intermediatePlusButton, { english_level("Intermediate+"); go_to_page("page4") })
    observeEvent(input$notSureButton, { english_level("Not sure"); go_to_page("page4") })

    output$teachers <- renderUI({
        get_all_teachers(
          id,
          selected_level = if(english_level() == "Not sure") teaching_levels[1] else english_level(),
          db_path = db_path,
          app_sys("app/www/teachers")
        )
    })

    selected_teacher <- reactiveVal()
    lapply(teachers, \(x){
      shinyjs::onclick(id = paste0("circle_", simplify_string(x)), {
        selected_teacher(x)
        go_to_page("page5")
      }
      )
    })

    output_label <- reactive({
      tagList(
        HTML("<br>"),
        htmltools::div(htmlEscape(input$name), class = "large-font"),
        tags$h3(paste0("Level: ", english_level())),
        tags$h3(paste0("Teacher: ", selected_teacher())),
      )
    })

    output$selection <- renderUI({
      bslib::card(
        output_label(),
        class = "card_custom"
      )
    })

    duplicate_students <- reactiveVal(NULL)
    current_availability <- reactiveVal(NULL)
    new_student <- reactiveVal(NULL)

    observeEvent(input$maintabs, {
      req(input$maintabs == "page5")
      new_student(NULL); duplicate_students(NULL); current_availability(NULL)
      req(english_level(), selected_teacher(), input$name)

      con <- get_db_connection(db_path)
      # save student information in database:
      student <- data.frame(
        "student" = input$name,
        "nationality" = input$nationality %||% "",
        "age" = input$age %||% "",
        "email" = input$email %||% "",
        "level" = english_level(),
        "teacher" = selected_teacher()
      )
      new_student(student)
      # verify if student is already in database:
      duplicates <- DBI::dbGetQuery(con, "SELECT * FROM student_info;") |>
        dplyr::mutate(age = as.character(age)) |>
        dplyr::inner_join(student, by = names(student))
      duplicate_students(duplicates)

      # select availability from selected teacher:
      sql <- "SELECT availability FROM teacher_info WHERE teacher = ?sel_teacher;"
      query <- DBI::sqlInterpolate(con, sql, sel_teacher = selected_teacher())
      availability <- DBI::dbGetQuery(con, query)$availability
      current_availability(as.numeric(availability))
    })


    observeEvent(input$confirm, {
      req(new_student())
      req(nrow(duplicate_students()) == 0)
      req(current_availability() > 0)
      req(file.exists(db_path))
      con <- get_db_connection(db_path)

      sql <- "UPDATE teacher_info SET availability = ?new WHERE teacher = ?sel_teacher;"
      query <- DBI::sqlInterpolate(con, sql, new =  max(c(current_availability() - 1, 0)),
                                     sel_teacher = selected_teacher())

      # only update data if we get past the requirements above:
      DBI::dbExecute(con, query)
      DBI::dbWriteTable(con, "student_info", new_student(), append = TRUE)

      # print label:
      shinyjs::js$custom_print(
        # cannot use output_label() here yet because of the HTML format
        name = htmltools::HTML(
          "<center><h1><b>", htmlEscape(input$name),
          "</b></h4>Level: ", htmlEscape(english_level()),
          "<br>Teacher: ", htmlEscape(selected_teacher()), "</center>"
          )
        )
      duplicate_students <- reactiveVal(NULL)
      current_availability <- reactiveVal(NULL)
      go_to_page("page6")
    })

    shinyjs::onclick("start_over", {
      updateTextInput(inputId = "name", value = character(0))
      updateTextInput(inputId = "nationality", value = character(0))
      updateTextInput(inputId = "age", value = character(0))
      updateTextInput(inputId = "email", value = character(0))
      selected_teacher(NULL)
      english_level(NULL)
      go_to_page("page1")
      })

    output$confirm_error <- renderText({
      validate(
        need(nrow(duplicate_students()) == 0, "Cannot confirm. Student already available in database.")
        )
      validate(
        need(current_availability() > 0, "Cannot confirm. Teacher is not available anymore")
      )
    })

  })
}

## To be copied in the UI
# mod_mod_first_page_ui("mod_first_page_1")

## To be copied in the server
# mod_mod_first_page_server("mod_first_page_1")

#' Add back button
#'
#' Internal function to create a back button in a consistent style.
#'
#' @noRd
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

#' Get all teachers
#'
#' Internal function to create pictures of teachers within a grid layout.#'
#'
#' @noRd
#'
get_all_teachers <- function(
    id,
    selected_level = "Basic",
    db_path = file.path(app_sys(), "fec_data.sqlite"),
    image_path = app_sys("app/www/teachers")
){
  ns <- NS(id)
  req(selected_level %in% teaching_levels)

  image_paths <- paste0("www/teachers/", list.files(image_path, pattern = ".png"))
  names(image_paths) <- gsub(".png", "", list.files(image_path, pattern = ".png"))
  validate(
    need(file.exists(db_path), "Database missing or path to database incorrect."),
    need("placeholder" %in% names(image_paths), "image folder needs at least a placeholder image.")
  )
  con <- get_db_connection(db_path)
  teacher_info <- DBI::dbGetQuery(con, "SELECT * FROM teacher_info;") |>
    dplyr::mutate(
      level_numeric = as.numeric(factor(level, levels = teaching_levels))
    )
  selected_teachers <- with(teacher_info, teacher[
    availability != 0 &
      level_numeric >=  ( match(selected_level, teaching_levels) %|NA|% 1 )
  ])
  if(length(selected_teachers) == 0) return({
    div("No more teachers available for the selected English level", class = "details-text")
    })

  all_items <- lapply(selected_teachers, \(x){
    image_name_x <- if(x %in% names(image_paths)) image_paths[[x]] else {
      image_paths[["placeholder"]]
    }
    bslib::layout_columns(
      class = "center-container",
      col_widths = 12,
      id = ns(paste0("circle_", simplify_string(x))),
      bslib::card_body(
        class = "center-container",
        fill = FALSE,
        fillable = FALSE,
        img(src = image_name_x, width = 80, height = 80) |>
          htmltools::tagAppendAttributes(class = "circle"),
        div(x, class = "details-text-small")
      )
    )
  })
  all_items[["width"]] <- "150px"
  do.call(bslib::layout_column_wrap, all_items )
}

add_logo <- function(path = "www/free_english_logo.png"){
  tags$img(src=path, class = "logo", width = "400px")
}
