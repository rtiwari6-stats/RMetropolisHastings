
#' Sample data from a univariate distribution using the Metropolis-Hastings Algorithm
#'
#' @param targetdensity This is the probability density function from which sampling will be done. This should be a function of x.
#' @param candidatedensity This is the candidate generation density to be used
#' @param numIter The number of samples to generate
#' @param initial_vec The staring vector for the algorithm
#' @param sigma_matrix standard deviation matrix of the candidate generation density
#' @param seed seed for generation of random samples
#'
#' @return a matrix of sample vectors
#' @export
#'
#' @examples
rmultivariatemh = function(targetdensity,  candidatedensity = c("Normal"),
                         numIter = 1000, initial_vec = NULL, sigma_matrix = NULL, seed = 1001L){
  candidatedensity = match.arg(candidatedensity)
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

  # initialize the x matrix to capture the generated samples
  x = matrix(rep(0, length(initial_vec) * (numIter)), nrow = numIter, byrow = TRUE)
  x[1, ] = initial_vec # initial the starting point
  set.seed(seed)
  #build the markov chain
  for(i in 2:numIter){
    # generate a  possible move in the markov chain
    nextVal = mvrnorm(1, x[i-1,], sigma_matrix)

    #compute the acceptance probability
    #this is a special case because the candidate is symmetric
    prevDensity = targetdensity(x[i-1, ])
    if(all(prevDensity == 0)){
      stop(paste('invalid value (0) returned by target density for x = ', x[, i-1]))
    }
    prob = min(1, targetdensity(nextVal) / prevDensity)
    u = runif(1)

    #accept the sample with 'prob' probability
    if(u <= prob){
      x[i, ] = nextVal
    }
    else{
      x[i, ] = x[i-1, ]
    }
  }
  return (x)
}
