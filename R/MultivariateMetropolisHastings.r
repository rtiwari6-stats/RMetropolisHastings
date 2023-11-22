
#' Sample data from a univariate distribution using the Metropolis-Hastings Algorithm
#'
#' @param targetdensity This is the probability density function from which sampling will be done. This should be a function of x.
#' @param candidatedensity This is the candidate generation density to be used
#' @param numIter The number of samples to generate
#' @param initial The staring value for the algorithm
#' @param plot plot the values of x
#' @param sigma standard deviation of the candidate generation density
#' @param seed seed for generation of random samples
#'
#' @return a vector of samples
#' @export
#'
#' @examples
rmultivariatemh = function(targetdensity,  candidatedensity=c("Normal"),
                         numIter=1000, initial=0.0, plot=FALSE, sigma_matrix=NULL, seed = 1001L){
  candidatedensity = match.arg(candidatedensity)
  #check sigma
  if(is.null(sigma_matrix)){
    stop('sigma matrix must not be null')
  }
  if(any(sigma_matrix[] <= 0){
    stop("sigma matrix must be positive")
  }
  #check target density
  if(is.null(targetdensity)){
    stop("Target density function must be provided")
  }
}
