# Package setup ---------------------------------------------------------------

# Install required packages:
# ! Comment out when deploying to rsconnect
# install.packages("pak")
# pak::pak("surveydown-dev/surveydown)

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
#db <- sd_db_connect()

# UI setup --------------------------------------------------------------------

ui <- sd_ui()

# Server setup ----------------------------------------------------------------

server <- function(input, output, session) {

  sd_show_if(
    #page2
    input$which_case_study == "other" ~ "which_case_study_other",
    #page3
    input$compilation == "no" ~ "compilation_error",
    input$overall_suggestions == "yes" ~ "overall_suggestions_to_improve",
    input$gen_org == "yes" ~ "gen_org_suggestions",
    input$main_viz == "yes" ~ "main_viz_suggestions",
    input$technical_errors == "yes" ~ "technical_errors_explained",
    input$stat_errors == "yes" ~ "stat_errors_explained",
    input$newer_equiv == "yes" ~ "newer_equiv_explained",
    input$resource_links == "yes" ~ "resource_links_explained",
    #page4
    input$class_use == "no" ~ "class_use_explained",
    input$topic_more == "yes" ~ "topic_more_explained",
    input$topic_less == "yes" ~ "topic_less_explained",
    input$limiting_barriers == "yes" ~ "limiting_barriers_explained",
    #page5
    input$standalone_missing == "yes" ~ "standalone_missing_explained",
    input$code_needs_more == "yes" ~ "code_needs_more_explained",
    #page6
    input$alt_text_present == "no" ~ "alt_text_present_explained",
    input$alt_text_useful == "no" ~ "alt_text_useful_explained",
    input$color_palette == "no" ~ "color_palette_explained",
    input$gen_accessibility == "yes" ~ "gen_accessibility_explained",
    #page7
    input$data_methods_limits == "no" ~ "data_methods_limits_explained",
    input$ethical_considerations == "yes" ~ "ethical_considerations_explained",
    input$disclaimers == "no" ~ "disclaimers_explained",
    input$relevant_diff_topic_resources == "no" ~ "relevant_diff_topic_resources_explained",
    #page8
    input$reproducibility_sections == "no" ~ "reproducibility_sections_explained",
    input$reproducibility_tools_tips == "yes" ~ "reproducibility_tools_tips_explained",
    input$reproducibility_code_robust == "yes" ~ "reproducibility_code_robust_explained"
  )

  # Run surveydown server and define database
  sd_server(db = db)
}

# Launch the app
shiny::shinyApp(ui = ui, server = server)
