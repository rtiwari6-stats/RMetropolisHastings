test_invalidinputs = test_that("test for invalid inputs", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #bad sigma
  expect_error(cppunivariatemh(sigma=-1))
  expect_error(cppunivariatemh(sigma = NULL))
  expect_error(cppunivariatemh(sigma = 0))

  #bad candidate pdf
  expect_error(cppunivariatemh(candidatedensity = "exp", sigma = 1))

  #bad targetDensity
  expect_error(cppunivariatemh(targetdensity = "Normal", sigma = 1))

})

test_reproducibility = test_that("test reproducibility of samples", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #test with same seed, same sigma
  y1 = cppunivariatemh(sigma=1)
  y2 = cppunivariatemh(sigma=1)
  expect_true(identical(y1, y2))

  #test with same seed, different sigma
  y3 = cppunivariatemh(sigma=10)
  expect_true(!identical(y3, y2))

  #test with different seed
  y4 = cppunivariatemh(seed=30, sigma=1)
  expect_true(!identical(y4, y1))
})

test_correctness = test_that("test correctness of samples (best effort)",{
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  start = 1.25
  y1 = cppunivariatemh(targetdensity = "Exponential", sigma=1, initial = start)
  expect_equal(y1[1], start)
  expect_equal(length(y1), 1000)
})
