# Package setup ---------------------------------------------------------------

# Install required packages:
# install.packages("pak")
# pak::pak("surveydown-dev/surveydown") # Development version from GitHub

# Load packages
library(surveydown)

# Database setup --------------------------------------------------------------
#
# Details at: https://surveydown.org/docs/storing-data
#
# surveydown stores data on any PostgreSQL database. We recommend
# https://supabase.com/ for a free and easy to use service.
#
# Once you have your database ready, run the following function to store your
# database configuration parameters in a local .env file:
#
# sd_db_config()
#
# Once your parameters are stored, you are ready to connect to your database.
# For this demo, we set ignore = TRUE in the following code, which will ignore
# the connection settings and won't attempt to connect to the database. This is
# helpful if you don't want to record testing data in the database table while
# doing local testing. Once you're ready to collect survey responses, set
# ignore = FALSE or just delete this argument.

db <- sd_db_connect(ignore = TRUE)
# db <- sd_db_connect(gssencmode = "disable")

# UI setup --------------------------------------------------------------------

ui <- sd_ui()

# Server setup ----------------------------------------------------------------

server <- function(input, output, session) {
  # Define any conditional skip logic here (skip to page if a condition is true)
  # ── Conditional SKIP logic ─────────────────────────────────────────────────
  sd_skip_if(
    
    # Consent screenout
    input$consent1 == "no" ~ "consent_screenout",
    input$consent2 == "no" ~ "consent_screenout",
    
    # Role-based branching
    input$role == "educator"     ~ "educator_main",
    input$role == "student"      ~ "end",
    input$role == "self_learner" ~ "end",
    input$role == "other"        ~ "other_role_end"
  )
  
  # ── Conditional SHOW logic ─────────────────────────────────────────────────
  sd_show_if(
    # Show "other" text fields only when "Other" is selected
    input$role == "other"                                          ~ "role_other",
    "other" %in% input$educator_brought                            ~ "educator_brought_other",
    "other" %in% input$student_types                               ~ "student_types_other",
    "other" %in% input$educator_case_studies_seen                  ~ "educator_case_studies_seen_other",
    input$educator_used_before == "other"                          ~ "educator_used_before_other"
  )
  
  # Run surveydown server and define database
  sd_server(db = db)
}

# Launch the app
shiny::shinyApp(ui = ui, server = server)

# Create a print version ------------------------------------------------------

# quarto::quarto_render(input = 'survey.qmd', output_format = 'html', output_file = 'print.html')
