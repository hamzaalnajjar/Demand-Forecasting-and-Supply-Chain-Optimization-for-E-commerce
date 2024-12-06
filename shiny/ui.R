# ui.R
library(shiny)

ui <- fluidPage(
  titlePanel("Demand Forecasting & Supply Chain Optimization"),
  sidebarLayout(
    sidebarPanel(
      selectInput("forecastModel", "Select Forecast Model:",
                  choices = c("ARIMA", "Random Forest")),
      actionButton("updateBtn", "Update Forecast")
    ),
    mainPanel(
      plotOutput("forecastPlot"),
      tableOutput("optimizationResults")
    )
  )
)
