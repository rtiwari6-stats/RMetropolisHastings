test_invalidinputs = test_that("test for invalid inputs", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #bad sigma
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(-1, 16), nrow = 4)))
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = NULL))
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(0, 16), nrow = 4)))

  #bad candidate pdf
  expect_error(rmultivariatemh(targetDensity, candidatedensity = "exp", initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 4)))

  #unspecified targetDensity
  expect_error(rmultivariatemh(NULL, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 4)))

  #invalid initial value for the given target density
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(-1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 4)))

  #non-compatible initial vector and sigma matrix
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 8)))
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 2)))
})
