# forecasting.R
library(forecast)
library(caret)

# Load preprocessed sales data
sales_data <- read.csv("data/processed_sales_data.csv")

# Aggregate data by week
sales_weekly <- sales_data %>%
  group_by(week = floor_date(Date, "week")) %>%
  summarise(weekly_sales = sum(Sales))

# Fit ARIMA model
arima_model <- auto.arima(sales_weekly$weekly_sales)

# Forecast next 12 weeks
forecast_arima <- forecast(arima_model, h = 12)

# Plot forecast
plot(forecast_arima)

# Use Random Forest for machine learning-based forecasting
set.seed(123)
rf_model <- train(weekly_sales ~ recency + frequency + monetary,
                  data = sales_data,
                  method = "rf")

# Forecast using Random Forest model
rf_forecast <- predict(rf_model, newdata = sales_data)

# Save models for later use
saveRDS(arima_model, "models/arima_model.rds")
saveRDS(rf_model, "models/rf_model.rds")
