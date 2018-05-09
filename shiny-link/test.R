## Install and load needed libraries
#install.packages("plotly")
library(plotly)
#install.packages("dplyr")
library(dplyr)
#install.packages("shiny")
library(shiny)
#install.packages("htmlwidgets")
library(htmlwidgets)

## Read in the fake csv data set about ice cream
ice.cream <- read.csv("icecream-img.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  headerPanel("Price per Scoops"),
  sidebarPanel(
    sliderInput("priceRange", label = h3("Price Range"), min = 0, 
                max = 10, value = c(2, 8))
  ),
  mainPanel(
    plotlyOutput("icePlot"),
    h4("Click on the dots to learn more about the ice cream flavor."),
    uiOutput("imageLink")
  )
)

server <- function(input, output) {
  output$icePlot <- renderPlotly({
    range.ice.cream <- ice.cream %>% filter(prices >= input$priceRange[1]) %>% filter(prices <= input$priceRange[2])
    plot_ly(range.ice.cream, x = ~prices, y = ~scoops, type = "scatter", mode = "markers",
            text = ~paste("Flavor:", flavors), key = ~images, source = "imgLink") %>% 
      layout(title = paste("Ice Cream Price vs Scoops Given")) 
  })
  
  output$imageLink <- renderText({
    event.data <- event_data(event = "plotly_click", source = "imgLink")
    if (is.null(event.data)) {
      print("Click to see the link of the point.")
    } else { 
      ice.cream <- ice.cream %>% filter(images == event.data$key)
      HTML('<p>Flavor:',ice.cream$flavors, '</p>','<p>X Value (Price):', event.data[["x"]], '</p>','<p>Y Value (Scoops):', event.data[["y"]],'</p>',
           '<a href="', ice.cream$images,'">', ice.cream$images,'</a>','<p>','<img src="',ice.cream$images, '"/>','</p>')
      #print(ice.cream)
    }
  })

}

shinyApp(ui = ui, server = server)
