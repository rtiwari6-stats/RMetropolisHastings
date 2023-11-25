test_invalidinputs = test_that("test for invalid inputs", {
  #need a target density that generates a single probability for a vector x
  targetDensity_mv = function(x){
    prob = rep(0, length(x))
    for(i in 1:length(x)){
      prob[i] = ifelse(x[i]<0,0,exp(-x))
    }
    return(max(prob))
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
  skip_if_not_installed("Matrix") # need this for nearPD function

  #need a target density that generates a single probability for a vector x
  targetDensity_mv = function(x){
    prob = rep(0, length(x))
    for(i in 1:length(x)){
      prob[i] = ifelse(x[i]<0,0,exp(-x))
    }
    return(max(prob))
  }

  #construct a PD sigma matrix
  n = 4
  M = matrix(runif(n*n), ncol=n)
  sigma_matrix = as.matrix(Matrix::nearPD(M)$mat)
  initial_vec = c(0.5, 1.5, -1.65, 1.45)
  #test with same seed, same sigma
  y1 = rmultivariatemh(targetDensity_mv, initial_vec = initial_vec, sigma_matrix = sigma_matrix)
  y2 = rmultivariatemh(targetDensity_mv, initial_vec = initial_vec, sigma_matrix = sigma_matrix)
  expect_true(identical(y1, y2))

  #test with same seed, different sigma
  #construct a different PD sigma matrix
  n = 4
  M = matrix(runif(n*n), ncol=n)
  sigma_matrix_1 = as.matrix(Matrix::nearPD(M)$mat)
  y3 = rmultivariatemh(targetDensity_mv,
                       initial_vec = initial_vec,
                       sigma_matrix = sigma_matrix_1)
  expect_true(!identical(y3, y2))

  #test with different seed
  y4 = rmultivariatemh(targetDensity_mv, seed=30,
                       initial_vec = initial_vec, sigma_matrix = sigma_matrix)
  expect_true(!identical(y4, y1))
})

