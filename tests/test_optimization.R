# test_optimization.R
library(testthat)

# testing for optimization results
test_that("Optimization result is a numeric vector", {
  solution <- ROI_solve(model)
  expect_is(solution$solution, "numeric")
})
