#include <Rcpp.h>

using namespace Rcpp;

//' C++ function to generate samples using univariate normal candidate density
//' @param targetDensity This is the probability density function from which sampling will be done. This should be a function of x.
//' @param numIter This is the number of iterations to run the algorithm
//' @param initial This is the starting value for the markov chain
//' @param sigma This is the standard deviation for candidate generating univariate normal distribution.
// [[Rcpp::export]]
NumericVector univariatemhnormalcpp(Function targetDensity, const NumericVector numIter,
                                    const NumericVector initial,
                                    const NumericVector sigma) {
  // skip checks because they are done in R before call
  // initialize the x vector to capture the generated samples
  const float init = initial[0];
  const float sd = sigma[0];
  const int n = numIter[0];
  NumericVector x(n);
  x[0] = init;
  //build the markov chain
  for(int i = 2; i <= n; i++){
    //generate a  possible move in the markov chain
    const NumericVector nextVal = rnorm(1, x[i-1], sd);
    //compute the acceptance probability
    //this is a special case because the candidate is symmetric
    const NumericVector prevDensity = targetDensity(x[i-1]);
    const NumericVector nextDensity = targetDensity(nextVal[0]);

    const double prob = std::min(1.0, nextDensity[0] / prevDensity[0]);
    const NumericVector u = runif(1);
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


