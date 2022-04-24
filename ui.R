library(shiny)
library(shinyjs)
library(shinycssloaders)

g_columns <- setNames(colnames(iris), gsub("\\.", " ", colnames(iris)))

# Define UI for application that draws a histogram
shinyUI(navbarPage("Iris Analysis",
                   tags$head(
                     tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                   ),

# Descriptive Analysis ----------------------------------------------------

                   tabPanel("Descriptive Analysis",
                            # Application title
                            useShinyjs(),
                            
                            # Sidebar with a slider input for number of bins 
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons("radio_switch_plot", "Choose a plot",
                                             c("histogram" = "histogram",
                                               "boxplot" = "boxplot")),
                                
                                radioButtons("radio_col", "Select Column",
                                             g_columns[1:4]),
                                
                                radioButtons("radio_color", "Select Color",
                                             c("blue" = "#008ae6",
                                               "grey" = "grey",
                                               "green" = "#00cc44",
                                               "red" = "#e63900")),
                                
                                sliderInput("bins",
                                            "Width of bins",
                                            min = 0.1,
                                            max = 0.5,
                                            value = 0.3),
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("plot1"),
                                textOutput("text1")
                              )
                            )
                          ),

# Clustering --------------------------------------------------------------

                   tabPanel("Clustering",
                            # Application title
                            useShinyjs(),
                            
                            # Sidebar with a slider input for number of bins 
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons("radio_y_clust", "Select y-axis",
                                             g_columns[1:4]),
                                radioButtons("radio_x_clust", "Select x-axis",
                                             g_columns[1:4],
                                             selected = "Sepal.Width"),
                                
                                sliderInput("num_clutser",
                                            "Number of clusters",
                                            min = 1,
                                            max = 6,
                                            value = 3),
                                actionButton("btn_plot_scatter", "create plot", icon = icon("chart-line")),
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                withSpinner(plotOutput("plot_scatter")),
                                textOutput("text2")
                              )
                            )
                          )
  )
)





























