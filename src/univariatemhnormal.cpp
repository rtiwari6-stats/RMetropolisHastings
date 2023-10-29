#include <Rcpp.h>
#include <cmath>

using namespace Rcpp;

//' C++ function to generate a probability from a univariate exponential density function
//' @param x This is the x value
// [[Rcpp::export]]
double targetDensityUnivarExp(float x){
  if (x < 0.0){
    return 0.0f;
  }
  else{
    return exp(-x);
  }
}

//' C++ function to generate samples using univariate normal candidate density
//' @param numIter This is the number of iterations to run the algorithm
//' @param initial This is the starting value for the markov chain
//' @param sigma This is the standard deviation for candidate generating univariate normal distribution.
// [[Rcpp::export]]
NumericVector univariatemhexpnormalcpp(NumericVector numIter,
                                    NumericVector initial, NumericVector sigma) {
  // skip rest checks because they are done in R before call
  // initialize the x vector to capture the generated samples
  NumericVector x(numIter[0]);
  x[0] = initial[0];
  //build the markov chain
  for(int i = 2; i <= numIter[0]; i++){
    //generate a  possible move in the markov chain
    NumericVector nextVal = rnorm(1, x[i-1], sigma[0]);
    //compute the acceptance probability
    //this is a special case because the candidate is symmetric
    double prevDensity = targetDensityUnivarExp(x[i-1]);
    double nextDensity = targetDensityUnivarExp(nextVal[0]);

    double prob = std::min(1.0, nextDensity / prevDensity);
    NumericVector u = runif(1);
    //accept the sample with 'prob' probability
    if(u[0] <= prob){
      x[i] = nextVal[0];
    }
    else{
      x[i] = x[i-1];
    }
  }
  return x;
}


