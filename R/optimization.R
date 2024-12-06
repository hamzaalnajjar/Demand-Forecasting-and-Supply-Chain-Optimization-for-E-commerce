# optimization.R
library(ROI)
library(ROI.plugin.glpk)

# parameters for inventory optimization
order_cost <- 50       # Cost per order
holding_cost <- 2      # Holding cost per unit
demand_forecast <- c(200, 220, 250, 230, 210, 240, 250, 260, 280, 270)  # Example forecast

# set up MILP model
model <- MILPModel()
model <- add.constraint(model, demand_forecast)
model <- add.objective(model, sense = "min", coefficients = c(order_cost, holding_cost))

# solving optimization problem
solution <- ROI_solve(model)

# shows output of optimized results
solution$solution
