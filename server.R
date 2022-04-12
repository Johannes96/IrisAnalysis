#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$plot1 <- renderPlot({
    
    if (input$radio_switch_plot == "histogram") {
      
      # create and show plot
      p <- ggplot(iris, aes_string(x = input$radio_col)) + 
        geom_histogram(binwidth = input$bins, fill = input$radio_color, col = "black") +
        ggtitle(paste("Histogram of", input$radio_col, sep = " ")) +
        theme(plot.title = element_text(size = 18))
      print(p)
      
      #hide or show ui elements
      show("bins")
      show("radio_col")
      show("radio_color")
      
    } else if (input$radio_switch_plot == "boxplot") {
      
      # create and show plot
      p <- ggplot(iris, aes_string(x="Species", y=input$radio_col)) +
        geom_boxplot(fill = input$radio_color) +
        ggtitle(paste("Boxplot of", input$radio_col, sep = " ")) +
        theme(plot.title = element_text(size = 18))
      print(p)
      
      #hide or show ui elements
      hide("bins")
      show("radio_col")
      show("radio_color")
      
    }
    
  })
  
  output$text1 <- renderText({
    if (input$radio_switch_plot == "histogram") {
      paste("You have selected", input$radio_col, "with", input$radio_switch_plot)
    } else if (input$radio_switch_plot == "boxplot") {
      paste("You have selected", input$radio_col, "with", input$radio_switch_plot)
    }
    
  })

})
