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
    input$compilation == "0" ~ "compilation_error",
    input$overall_suggestions == "1" ~ "overall_suggestions_to_improve",
    input$main_viz == "1" ~ "main_viz_suggestions",
    input$technical_errors == "1" ~ "technical_errors_explained",
    input$stat_errors == "1" ~ "stat_errors_explained",
    input$newer_equiv == "1" ~ "newer_equiv_explained",
    input$resource_links == "1" ~ "resource_links_explained",
    #page4
    input$class_use == "0" ~ "class_use_explained",
    input$topic_more == "1" ~ "topic_more_explained",
    input$topic_less == "1" ~ "topic_less_explained",
    input$limiting_barriers == "1" ~ "limiting_barriers_explained",
    #page5
    input$standalone_missing == "1" ~ "standalone_missing_explained",
    input$code_needs_more == "1" ~ "code_needs_more_explained",
    #page6
    input$alt_text_present == "0" ~ "alt_text_present_explained",
    input$alt_text_useful == "0" ~ "alt_text_useful_explained",
    input$color_palette == "0" ~ "color_palette_explained",
    input$gen_accessibility == "1" ~ "gen_accessibility_explained",
    #page7
    input$human_data == "1" ~ "data_sex_descriptions",
    input$human_data == "1" ~ "data_collection_description",
    input$human_data == "1" ~ "data_limitations",
    input$human_data == "1" ~ "data_race_descriptions",
    input$data_race_descriptions == "0" ~ "data_sampling",
    input$data_race_descriptions == "0" ~ "label_inclusion",
    input$data_race_descriptions == "0" ~ "label_origin",
    input$data_race_descriptions == "0" & input$data_sampling == "1" & input$label_inclusion == "1" & input$label_origin == "1" ~ "needed_race_bp_limit",
    input$ai_use == "1" ~ "ai_bias",
    input$ai_use == "1" ~ "inclusive_dataset",
    input$gen_inclusivity == "1" ~ "gen_inclusivity_explained",
    #page8
    input$data_methods_limits == "0" ~ "data_methods_limits_explained",
    input$data_methods_limits_needed == "1" ~ "data_methods_limits_needed_explained",
    #page9
    input$reproducibility_sections == "0" ~ "reproducibility_sections_explained",
    input$reproducibility_tools_tips == "1" ~ "reproducibility_tools_tips_explained",
    input$reproducibility_code_robust == "1" ~ "reproducibility_code_robust_explained"
  )

  # Run surveydown server and define database
  sd_server(db = db)
}

# Launch the app
shiny::shinyApp(ui = ui, server = server)
