library(shiny)
library(shinyjs)

g_columns <- setNames(colnames(iris), gsub("\\.", " ", colnames(iris)))

# Define UI for application that draws a histogram
shinyUI(navbarPage("Iris Analysis",

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
                            verbatimTextOutput("placeholder1"))


  )
)
