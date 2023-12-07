
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RMetropolisHastings

<!-- badges: start -->

[![R-CMD-check](https://github.com/rtiwari6-stats/RMetropolisHastings/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rtiwari6-stats/RMetropolisHastings/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/rtiwari6-stats/RMetropolisHastings/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/rtiwari6-stats/RMetropolisHastings/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

# Description

Metropolis-Hastings (M-H) algorithm is a markov chain based approach
that provides a way to generate samples from a distribution from which
direct sampling is difficult. It does this by simulating samples from a
different distribution from which direct sampling is easier, and
accepting those samples with a probability. We will build a R package
that implements the M-H algorithm. Our package offers support for
univariate and multivariate sampling using the M-H algorithm.

## Installation

You can install the development version of RMetropolisHastings from
[GitHub](https://github.com/rtiwari6-stats/RMetropolisHastings) with:

``` r
if (!require("devtools")){
  install.packages("devtools") 
}
#> Loading required package: devtools
#> Warning: package 'devtools' was built under R version 4.2.3
#> Loading required package: usethis
#> Warning: package 'usethis' was built under R version 4.2.3
library(devtools)
devtools::install_github("rtiwari6-stats/RMetropolisHastings")
#> Skipping install of 'RMetropolisHastings' from a github remote, the SHA1 (5f8a07ae) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Examples

This is an example which shows you how to generate 1000 univariate
samples:

``` r
library(RMetropolisHastings)
targetDensity = function(x){
    return(ifelse(x<0, 0, exp(-x)))
}
start = 1.25
y1 = runivariatemh(targetDensity, sigma = 1, initial = start, plot = TRUE)
```

<img src="man/figures/README-example-1.png" width="100%" /><img src="man/figures/README-example-2.png" width="100%" />

``` r
#print a few samples
y1[1:5]
#> [1] 1.250000 1.250000 1.045988 1.045988 1.769581
```

This is an example which shows you how to generate 1000 univariate
samples using rcpp:

``` r
library(RMetropolisHastings)
#does not take a userdefined targetDensity
start = -1.25
y1 = cppunivariatemh(targetdensity = "Exponential", sigma = 1, initial = start, plot = TRUE)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" /><img src="man/figures/README-unnamed-chunk-3-2.png" width="100%" />

``` r
#print a few samples
y1[1:5]
#> [1] -1.25  0.00  0.00  0.00  0.00
```

This is an example which shows you how to generate 1000 multivariate
samples:

``` r
if (!require("Matrix")){
  install.packages("Matrix") 
}
#> Loading required package: Matrix
if (!require("stats")){
  install.packages("stats") 
}
library(RMetropolisHastings)

n = 4
M = matrix(runif(n * n), ncol = n)
sigma_matrix = as.matrix(Matrix::nearPD(M)$mat)
initial_vec = rnorm(n)

#need a target density that generates a single probability for a vector x
targetDensity_mv = function(x){
    prob = rep(0, length(x))
    for(i in 1:length(x)){
      prob[i] = ifelse(x[i] < 0, 0, exp(-x))
    }
    return(max(prob))
}
  
y1 = rmultivariatemh(targetdensity = targetDensity_mv, initial_vec = initial_vec, sigma_matrix = sigma_matrix)
#print some samples
y1[1:5]
#> [1] 1.2869276 1.2869276 0.7146032 0.7146032 1.3378602
```

This is an example which shows you how to generate 1000 multivariate
samples using rcpp:

``` r
library(RMetropolisHastings)
if (!require("Matrix")){
  install.packages("Matrix") 
}
if (!require("stats")){
  install.packages("stats") 
}
library(Matrix)
library(stats)
n = 4
M = matrix(runif(n * n), ncol = n)
sigma_matrix = as.matrix(Matrix::nearPD(M)$mat)
initial_vec = rnorm(n)

#does not take a userdefined targetDensity
y1 = cppmultivariatemh(targetdensity = "Exponential", initial_vec = initial_vec, 
                     sigma_matrix = sigma_matrix)
#print some samples
y1[1:5]
#> [1] -1.1785860 -1.0394855 -1.3177983 -0.6420437 -0.6420437
```

# References

Understanding the Metropolis-Hastings Algorithm. Siddhartha Chib and
Edward Greenberg. The American Statistician , Nov., 1995, Vol. 49, No. 4
(Nov., 1995), pp. 327-335

# Contributions

Rohan Tiwari’s contributions include github setup, univariate
implementation and tests in R and cpp, assistance with multivariate R
and cpp, and setup github actions for code coverage and “R CMD Check”.

Skylar Liu’s contributions include multivariate implementation and tests
in R and cpp, and assistance to Rohan with the readme file.
