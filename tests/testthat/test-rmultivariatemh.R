test_invalidinputs = test_that("test for invalid inputs", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #bad sigma matrix
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = diag(-1, nrow = 4)))
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = NULL))

  #bad candidate pdf
  expect_error(rmultivariatemh(targetDensity, candidatedensity = "exp", initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 4)))

  #unspecified targetDensity
  expect_error(rmultivariatemh(NULL, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 4)))

  #non-compatible initial vector and sigma matrix
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 8)))
  expect_error(rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 2)))
})

test_reproducibility = test_that("test reproducibility of samples", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #test with same seed, same sigma
  y1 = rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = diag(1, nrow = 4))
  y2 = rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = diag(1, nrow = 4))
  expect_true(identical(y1, y2))

  #test with same seed, different sigma
  y3 = rmultivariatemh(targetDensity, initial_vec = rep(1, 4), sigma_matrix = matrix(rep(5, 16), nrow = 4))
  expect_true(!identical(y3, y2))

  #test with different seed
  y4 = rmultivariatemh(targetDensity, seed=30, initial_vec = rep(1, 4), sigma_matrix = diag(1, nrow = 4))
  expect_true(!identical(y4, y1))
})

