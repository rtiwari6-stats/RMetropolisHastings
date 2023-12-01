
#' Sample data from a multivariate distribution using the Metropolis-Hastings Algorithm using a cpp implementation.
#' The use of this function is recommended when the target density function is in the predefined set of densities in the function's API.
#' @param targetdensity This is the probability density function from which sampling will be done. This should be one of the supported values:
#' "Exponential"- Exponential distribution.
#' @param candidatedensity This is the candidate generation density to be used. This should be one of the supported values
#' @param numIter The number of samples to generate
#' @param initial_vec The staring vector for the algorithm
#' @param sigma_matrix standard deviation matrix of the candidate generation density
#' @param seed seed for generation of random samples
#'
#' @return a matrix of sample vectors
#' @export
#'
#' @examples
cppmultivariatemh = function(targetdensity=c("Exponential"),  candidatedensity=c("Normal"),
                           numIter=1000, initial_vec=NULL,
                           sigma_matrix=NULL, seed = 1001L){
  candidatedensity = match.arg(candidatedensity)
  targetdensity = match.arg(targetdensity)
  #check sigma
  if(is.null(sigma_matrix)){
    stop('sigma matrix must not be null')
  }
  if(any(diag(sigma_matrix) < 0)){
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

  #call the cpp function
  set.seed(seed)
  #assume normal candidate generation density
  x = NULL
  if(targetdensity == "Exponential"){
    x =   multivariatemhexpnormalcpp(numIter, initial_vec, sigma_matrix)
  }
  return (x)
}
