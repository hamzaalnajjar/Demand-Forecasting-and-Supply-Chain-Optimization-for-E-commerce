# test_forecasting.R
library(testthat)

# testing for ARIMA model
test_that("ARIMA model forecast is not NULL", {
  arima_model <- readRDS("models/arima_model.rds")
  forecast_result <- forecast(arima_model, h = 12)
  expect_true(!is.null(forecast_result))
})
