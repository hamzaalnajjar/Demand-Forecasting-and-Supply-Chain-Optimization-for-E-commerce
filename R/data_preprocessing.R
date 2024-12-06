# data_preprocessing.R
library(dplyr)
library(tidyr)
library(lubridate)

# load sales data (replace with your file path)
sales_data <- read.csv("data/sales_data.csv")

# converting date column to Date type
sales_data$Date <- as.Date(sales_data$Date, format="%Y-%m-%d")

# fill missing values using forward fill
sales_data <- sales_data %>%
  fill(everything(), .direction = "downup")

# feature engineering: Recency, Frequency, and Monetary (RFM) metrics
sales_data <- sales_data %>%
  mutate(
    recency = as.numeric(difftime(Sys.Date(), Date, units = "days")),
    frequency = ave(Date, CustomerID, FUN = function(x) length(x)),
    monetary = ave(Sales, CustomerID, FUN = sum)
  )

# save processed data
write.csv(sales_data, "data/processed_sales_data.csv", row.names = FALSE)
