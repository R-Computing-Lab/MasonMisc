#' syndata
#' @param n Sample Size
#' @param df Data Frame
#' @param cov.mat Covariance matrix
#' @param means Means
#' @param varnames Variable Names
#' @param ... Additional Stuff
#' @return Generates multivariate normal data from a either a data frame or covariance matrix (\code{cov.mat}) of length \code{n}
#' @importFrom stats cov
#' @importFrom Matrix colMeans
#' @importFrom  MASS mvrnorm


syndata <- function(df=NULL,
                    n=300,
                    cov.mat=NULL,
                    means=NULL,
                    varnames=NULL,
                    ...) {
  if(is.null(df)&is.null(cov.mat)){
    stop("You must provide either a data frame or a covariance matrix for this function to work")}
  if(!is.null(df)){ #has data frame
    cov.mat= stats::cov(df)
    means=Matrix::colMeans(df)
    varnames=names(df)
  }
  if(is.null(means)){ #missing means
        means=rep(0,ncol(cov.mat))
  }

  data_sim=as.data.frame(MASS::mvrnorm(
      n,
      means,
      cov.mat))

  if(!is.null(varnames)){
    names(data_sim)=varnames
    }
return(data_sim)
}


