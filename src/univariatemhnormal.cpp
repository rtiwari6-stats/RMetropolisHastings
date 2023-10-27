#include <Rcpp.h>

using namespace Rcpp;

//' C++ function to generate samples using univariate normal candidate density
//' @param targetDensity This is the probability density function from which sampling will be done. This should be a function of x.
//' @param numIter This is the number of iterations to run the algorithm
//' @param initial This is the starting value for the markov chain
//' @param sigma This is the standard deviation for candidate generating univariate normal distribution.
// [[Rcpp::export]]
NumericVector univariatemhnormalcpp(Function targetDensity, NumericVector numIter,
                                    NumericVector initial, NumericVector sigma) {
  // skip checks because they are done in R before call
  // initialize the x vector to capture the generated samples
  NumericVector x(numIter[0]);
  x[0] = initial[0];
  //build the markov chain
  for(int i = 2; i <= numIter[0]; i++){
    //generate a  possible move in the markov chain
    NumericVector nextVal = rnorm(1, x[i-1], sigma[0]);
    //compute the acceptance probability
    //this is a special case because the candidate is symmetric
    NumericVector prevDensity = targetDensity(x[i-1]);
    NumericVector nextDensity = targetDensity(nextVal[0]);

    double prob = std::min(1.0, nextDensity[0] / prevDensity[0]);
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


