#include <Rcpp.h>
#include <cmath>

using namespace Rcpp;

//' C++ function to generate a probability from a multivariate exponential density function
//' @param x This is the x value
// [[Rcpp::export]]
double targetDensityMultivarExp(float x){
  if (x < 0.0){
    return 0.0f;
  }
  else{
    return exp(-x);
  }
}

//' C++ function to generate samples using multivariate normal candidate density
//' @param numIter This is the number of iterations to run the algorithm
//' @param initial_vec This is the starting vector for the markov chain
//' @param sigma_matrix This is the standard deviation matrix for candidate generating multivariate normal distribution.
// [[Rcpp::export]]
NumericMatrix multivariatemhexpnormalcpp(NumericVector numIter,
                                       NumericVector initial_vec, NumericMatrix sigma_matrix) {
  // skip rest checks because they are done in R before call
  // initialize the x matrix to capture the generated samples
  NumericMatrix x(numIter, size(initial_vec));
  x[0, ] = initial_vec;
  //build the markov chain
  for(int i = 2; i <= numIter[0]; i++){
    //generate a  possible move in the markov chain
    NumericVector nextVal = mvnorm(1, x[i-1, ], sigma_matrix[0, ]);
    //compute the acceptance probability
    //this is a special case because the candidate is symmetric
    double prevDensity = targetDensityUnivarExp(x[i-1, ]);
    double nextDensity = targetDensityUnivarExp(nextVal[0]);

    double prob = std::min(1.0, nextDensity / prevDensity);
    NumericVector u = runif(1);
    //accept the sample with 'prob' probability
    if(u[0] <= prob){
      x[i, ] = nextVal[0];
    }
    else{
      x[i, ] = x[i-1, ];
    }
  }
  return x;
}
