test_invalidinputs = test_that("test for invalid inputs", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #bad sigma
  expect_error(cppunivariatemh(targetDensity, sigma=-1))
  expect_error(cppunivariatemh(targetDensity, sigma = NULL))
  expect_error(cppunivariatemh(targetDensity, sigma = 0))

  #bad candidate pdf
  expect_error(cppunivariatemh(targetDensity, candidatedensity = "exp", sigma = 1))

  #unspecified targetDensity
  expect_error(cppunivariatemh(NULL, sigma = 1))

})

test_reproducibility = test_that("test reproducibility of samples", {
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  #test with same seed, same sigma
  y1 = cppunivariatemh(targetDensity, sigma=1)
  y2 = cppunivariatemh(targetDensity, sigma=1)
  expect_true(identical(y1, y2))

  #test with same seed, different sigma
  y3 = cppunivariatemh(targetDensity, sigma=10)
  expect_true(!identical(y3, y2))

  #test with different seed
  y4 = cppunivariatemh(targetDensity, seed=30, sigma=1)
  expect_true(!identical(y4, y1))
})

test_correctness = test_that("test correctness of samples (best effort)",{
  targetDensity = function(x){
    return(ifelse(x<0,0,exp(-x)))
  }
  start = 1.25
  y1 = cppunivariatemh(targetDensity, sigma=1, initial = start)
  expect_equal(y1[1], start)
  expect_equal(length(y1), 1000)
})
