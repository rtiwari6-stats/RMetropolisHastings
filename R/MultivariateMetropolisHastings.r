
#' Sample data from a univariate distribution using the Metropolis-Hastings Algorithm
#'
#' @param targetdensity This is the probability density function from which sampling will be done. This should be a function of x.
#' @param candidatedensity This is the candidate generation density to be used
#' @param numIter The number of samples to generate
#' @param initial_vec The staring vector for the algorithm
#' @param plot plot the values of x
#' @param sigma_matrix standard deviation matrix of the candidate generation density
#' @param seed seed for generation of random samples
#'
#' @return a matrix of sample vectors
#' @export
#'
#' @examples
rmultivariatemh = function(targetdensity,  candidatedensity = c("Normal"),
                         numIter = 1000, initial_vec = NULL, plot = FALSE, sigma_matrix = NULL, seed = 1001L){
  candidatedensity = match.arg(candidatedensity)
  #check sigma
  if(is.null(sigma_matrix)){
    stop('sigma matrix must not be null')
  }
  if(any(diag(sigma_matrix) <= 0)){
    stop("diagonal of sigma matrix must be positive")
  }
  #check target density
  if(is.null(targetdensity)){
    stop("Target density function must be provided")
  }
  #check initial vector and sigma matrix compatibility
  if(nrow(sigma_matrix) != length(initial_vec) | ncol(sigma_matrix) != length(initial_vec)){
    stop("number of rows and columns of sigma matrix must equal length of initial vector")
  }

  # initialize the x matrix to capture the generated samples
  x = matrix(rep(initial, numIter), nrow = numIter)
  set.seed(seed)

}
