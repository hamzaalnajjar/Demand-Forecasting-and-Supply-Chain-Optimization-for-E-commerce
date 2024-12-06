# server.R
library(shiny)
library(forecast)
library(randomForest)

server <- function(input, output) {

  # loading pre-trained models
  arima_model <- readRDS("models/arima_model.rds")
  rf_model <- readRDS("models/rf_model.rds")
  
  # reactivley update forecast based on user input
  observeEvent(input$updateBtn, {
    if(input$forecastModel == "ARIMA") {
      forecast_result <- forecast(arima_model, h = 12)
    } else {
      forecast_result <- predict(rf_model, newdata = sales_data)
    }
    
    # display forecast plot
    output$forecastPlot <- renderPlot({
      plot(forecast_result)
    })
    
    # displays optimized supply chain results (for simplicity, using own example data)
    output$optimizationResults <- renderTable({
      data.frame(Order_Quantity = c(100, 110, 120), Reorder_Point = c(50, 60, 70))
    })
  })
}

shinyApp(ui = ui, server = server)
