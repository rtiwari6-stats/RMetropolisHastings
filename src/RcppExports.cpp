// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// rcpp_hello
List rcpp_hello();
RcppExport SEXP _RMetropolisHastings_rcpp_hello() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(rcpp_hello());
    return rcpp_result_gen;
END_RCPP
}
// targetDensityUnivarExp
double targetDensityUnivarExp(float x);
RcppExport SEXP _RMetropolisHastings_targetDensityUnivarExp(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< float >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(targetDensityUnivarExp(x));
    return rcpp_result_gen;
END_RCPP
}
// univariatemhexpnormalcpp
NumericVector univariatemhexpnormalcpp(NumericVector numIter, NumericVector initial, NumericVector sigma);
RcppExport SEXP _RMetropolisHastings_univariatemhexpnormalcpp(SEXP numIterSEXP, SEXP initialSEXP, SEXP sigmaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type numIter(numIterSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type initial(initialSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type sigma(sigmaSEXP);
    rcpp_result_gen = Rcpp::wrap(univariatemhexpnormalcpp(numIter, initial, sigma));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_RMetropolisHastings_rcpp_hello", (DL_FUNC) &_RMetropolisHastings_rcpp_hello, 0},
    {"_RMetropolisHastings_targetDensityUnivarExp", (DL_FUNC) &_RMetropolisHastings_targetDensityUnivarExp, 1},
    {"_RMetropolisHastings_univariatemhexpnormalcpp", (DL_FUNC) &_RMetropolisHastings_univariatemhexpnormalcpp, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_RMetropolisHastings(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
