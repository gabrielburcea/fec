devtools::load_all(".")
database_path <- file.path(app_sys(), "fec_data.sqlite")

teaching_levels <- c("Basic", "Intermediate", "Intermediate+")
usethis::use_data(teaching_levels, overwrite = TRUE)

excel_path <- app_sys("data-raw", "fec_data.xlsx")

teacher_info <- readxl::read_excel(
  excel_path, sheet = "teacher_info", col_types = "text"
)

student_info <- readxl::read_excel(
  excel_path, sheet = "student_info", col_types = "text"
)

con <- DBI::dbConnect(RSQLite::SQLite(), database_path)
DBI::dbWriteTable(con, "teacher_info", teacher_info)
DBI::dbWriteTable(con, "student_info", student_info)
DBI::dbDisconnect(con)
