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
  
  create_scatter <- eventReactive(input$btn_plot_scatter, {
    
    if (input$radio_x_clust != input$radio_y_clust) {
      
      df_temp <- iris %>%
        select(-"Species") %>%
        scale()
      
      km_iris <- kmeans(df_temp, centers = input$num_clutser)
      
      iris_clustered <- iris %>%
        cbind(km_iris$cluster) %>%
        dplyr::rename(cluster = "km_iris$cluster")%>%
        dplyr::mutate(cluster = as.factor(cluster))
      
      p_s <- ggplot(iris_clustered, aes_string(x = input$radio_x_clust, y = input$radio_y_clust, color = "cluster", shape = "Species")) +
        geom_point(size = 3) +
        theme_bw()
      
      print(p_s)
    } else {
      showNotification(paste("Please select distinct x and y-values"), duration = 4, type = "warning")
    }
    
    })
  
  output$plot_scatter <- renderPlot({
    create_scatter()
  })
  
})