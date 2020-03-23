#' syndata
#' @param n Sample Size
#' @param df Data Frame
#' @param cov.mat Covariance matrix
#' @param cor.mat Correlation matrix
#' @param means Means
#' @param var.names Variable Names
#' @param var.class Variable Class
#' @param ... Additional Stuff
#' @return Generates multivariate normal data from either a data frame \code{df} or covariance matrix (\code{cov.mat}) or correlation matrix (\code{cov.mat}) of length \code{n}
#' @importFrom stats cov
#' @importFrom Matrix colMeans
#' @importFrom  MASS mvrnorm


syndata <- function(df=NULL,
                    n=300,
                    cov.mat=NULL,
                    cor.mat=NULL,
                    means=NULL,
                    var.names=NULL,
                    var.class=NULL,
                    ...) {
  if(is.null(df)&is.null(cov.mat)&is.null(cor.mat)){
    stop("You must provide either a data frame, a covariance matrix, or a correlation matrix for this function to work")
    }

  # has data frame
  if(!is.null(df)){
  # Check data class
    var.class= sapply(df, class)


    cov.mat= stats::cov(df,use = "na.or.complete")
    means=Matrix::colMeans(df,na.rm=TRUE)
    if(is.null(var.names)){
    var.names=names(df)
    }
  }

  # correlation matrix | cov natrix
  if(!is.null(cov.mat)|!is.null(cor.mat)){
    if(!is.null(cor.mat)){
      cov.mat=cor.mat
    }

    # missing means
    if(is.null(means)){
      means=rep(0,ncol(cov.mat))
    }
  }
  data_sim=as.data.frame(MASS::mvrnorm(
      n=n,
      mu=means,
      Sigma=cov.mat))

  if(!is.null(var.names)){
    names(data_sim)=var.names
    }
return(data_sim)
}


