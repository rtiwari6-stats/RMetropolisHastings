#include <RcppArmadillo.h>
#include <cmath>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;

//' C++ function to generate a probability from a multivariate exponential density function
//' @param x This is the x value
// [[Rcpp::export]]
double targetDensityMultivarExp(const arma::rowvec& x){
  double maxProba = 0.0;
  for(size_t i = 0; i < x.size(); i++ ){
    double proba = 0.0;
    if (x(i) < 0.0){
      proba = 0.0;
    }
    else{
      proba = exp(-x(i));
    }
    if(proba > maxProba){
      maxProba = proba;
    }
  }
  return maxProba;
}

//' C++ function to generate a multivariate exponential normal function
 //' @param n This is the number of samples
 //' @param mu This is the mean vector
 //' @param sigma This is the sigma matrix
// [[Rcpp::export]]
arma::mat mvrnormArma(int n, arma::rowvec mu, arma::mat sigma) {
  int ncols = sigma.n_cols;
  arma::mat Y = arma::randn(n, ncols);
  return arma::repmat(mu, 1, n) + Y * arma::chol(sigma);
}

//' C++ function to generate samples using multivariate normal candidate density
//' @param numIter This is the number of iterations to run the algorithm
//' @param initial_vec This is the starting vector for the markov chain
//' @param sigma_matrix This is the standard deviation matrix for candidate generating multivariate normal distribution.
// [[Rcpp::export]]
arma::mat multivariatemhexpnormalcpp(const arma::vec& numIter,
                                         const arma::rowvec& initial_vec,
                                         const arma::mat& sigma_matrix) {
  // skip rest checks because they are done in R before call
  // initialize the x matrix to capture the generated samples
  size_t n = numIter(0);
  arma::mat x(n, initial_vec.size());
  x.row(0) = initial_vec;
  //build the markov chain
  for(size_t i = 1; i <= n-1; i++){
    //generate a  possible move in the markov chain
    arma::mat nextVal = mvrnormArma(1, x.row(i-1), sigma_matrix);
    //compute the acceptance probability
    //this is a special case because the candidate is symmetric
    double prevDensity = targetDensityMultivarExp(x.row(i-1));
    double nextDensity = targetDensityMultivarExp(nextVal.row(0));

    double prob = std::min(1.0, nextDensity / prevDensity);
    NumericVector u = runif(1);
    //accept the sample with 'prob' probability
    if(u[0] <= prob){
      x.row(i) = nextVal.row(0);
    }
    else{
      x.row(i) = x.row(i-1);
    }
  }
  return x;
}
