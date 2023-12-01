test_invalidinputs = test_that("test for invalid inputs", {
  #bad sigma matrix
  expect_error(cppmultivariatemh(initial_vec = rep(1, 4), sigma_matrix = diag(-1, nrow = 4)))
  expect_error(cppmultivariatemh(initial_vec = rep(1, 4), sigma_matrix = NULL))

  #bad candidate pdf
  expect_error(cppmultivariatemh(candidatedensity = "exp", initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 4)))

  #non-compatible initial vector and sigma matrix
  expect_error(cppmultivariatemh(initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 8)))
  expect_error(cppmultivariatemh(initial_vec = rep(1, 4), sigma_matrix = matrix(rep(1, 16), nrow = 2)))
})

test_reproducibility = test_that("test reproducibility of samples", {
  skip_if_not_installed("Matrix") # need this for nearPD function

  #construct a PD sigma matrix
  n = 4
  M = matrix(runif(n*n), ncol=n)
  sigma_matrix = as.matrix(Matrix::nearPD(M)$mat)
  initial_vec = c(0.5, 1.5, -1.65, 1.45)
  #test with same seed, same sigma
  y1 = cppmultivariatemh(initial_vec = initial_vec, sigma_matrix = sigma_matrix)
  y2 = cppmultivariatemh(initial_vec = initial_vec, sigma_matrix = sigma_matrix)
  expect_true(identical(y1, y2))

  #test with same seed, different sigma
  #construct a different PD sigma matrix
  n = 4
  M = matrix(runif(n*n), ncol=n)
  sigma_matrix_1 = as.matrix(Matrix::nearPD(M)$mat)
  y3 = cppmultivariatemh(initial_vec = initial_vec,
                       sigma_matrix = sigma_matrix_1)
  expect_true(!identical(y3, y2))

  #test with different seed
  y4 = cppmultivariatemh(seed=30,
                       initial_vec = initial_vec, sigma_matrix = sigma_matrix)
  expect_true(!identical(y4, y1))
})

