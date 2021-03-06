source("asteroid.R")
source("distance_analysis.r")
source("static_map.R")


# Start shinyServer
shinyServer(function(input, output) {


  # Render Distance Bubble Map
  output$Distance <- renderPlotly(
    graph
  )

  # Render Static Map based on Date
  
  output$static <- renderPlotly(get_graph(input$date))

  # Render Information Tab about the asteroids as a whole
  output$scatter <- renderPlot({
    title <- paste0("Relationship between ", input$col1, " and ", input$col2)
    p <- ggplot(data = relevant) +
      geom_point(
        mapping = aes(x = relevant[[input$col1]], y = relevant[[input$col2]], color = df$name),
        size = 8
      ) +
      labs(x = input$col1, y = input$col2, title = title) +
      theme_solarized_2(light = FALSE) +
      geom_label_repel(aes(
        x = relevant[[input$col1]], y = relevant[[input$col2]],
        label = df$name
      ),
      alpha = 0.5, box.padding = 1,
      point.padding = 0.5
      )
    p
  })
})
