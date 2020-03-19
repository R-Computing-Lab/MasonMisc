#' syndata
#' @param n Sample Size
#' @param data Data
#' @param sigma Covariance matrix
#' @param means Means
#' @return Generates multivariate normal data from a covariance matrix (\code{sigma}) of length \code{n}

syndata <- function(df=NULL,
                    n=300,
                    Sigma=NULL,
                    means=NULL,
                    varnames=NULL,
                    ...) {
  require(MASS)
  require(Matrix)
  if(!is.null(df)){ #has data frame
    Sigma= cov(df)
    means=Matrix::colMeans(df)
    varnames=names(df)
  }
  if(is.null(means)){ #missing means
        means=rep(0,ncol(Sigma))
  }

  data_sim=as.data.frame(MASS::mvrnorm(
      n,
      mu,
      Sigma))

  if(!is.null(varnames)){
    names(data_sim)=varnames
    }
return(data_sim)
}


syndata(df=data_sim)


library(Matrix)   # ... for matrix operations
library(matrixStats)
library(stats)    # ... for statistical operations
library(MASS)     # ... for Multivariate Normal Distribution
library(reshape2)


Sigma=matrix(c(0.683,0.388,0.438,0.442,0.222,0.419,0.395,0.420,0.298,0.337,
               0.388,1.012,0.481,0.599,0.242,0.519,0.409,0.482,0.251,0.308,
               0.438,0.481,1.836,1.021,0.686,0.511,0.407,0.811,0.652,0.675,
               0.442,0.599,1.021,1.208,0.655,0.776,0.662,0.664,0.514,0.491,
               0.222,0.242,0.686,0.655,0.849,0.566,0.509,0.440,0.427,0.439,
               0.419,0.519,0.511,0.776,0.566,0.738,0.615,0.445,0.344,0.388,
               0.395,0.409,0.407,0.662,0.509,0.615,0.663,0.433,0.401,0.478,
               0.420,0.482,0.811,0.664,0.440,0.445,0.433,0.911,0.532,0.436,
               0.298,0.251,0.652,0.514,0.427,0.344,0.401,0.532,0.636,0.451,
               0.337,0.308,0.675,0.491,0.439,0.388,0.478,0.436,0.451,0.720),byrow=TRUE, nrow=10)

## Means by day
mu=c(1.9,2,3,2.2,2,1.9,1.8,1.9,1.8,1.9)

## Generate multivariate norm data by cov and mu, sample size 300
data_sim=as.data.frame(mvrnorm(
  300,
  mu,
  Sigma))
## rename simulated data
names(data_sim)= c("senseofcontrol_t1","senseofcontrol_t2",
                   "senseofcontrol_t3","senseofcontrol_t4",
                   "senseofcontrol_t5","senseofcontrol_t6",
                   "senseofcontrol_t7","senseofcontrol_t8",
                   "senseofcontrol_t9","senseofcontrol_t10")
## create variables
### id
data_sim$id=c(1:nrow(data_sim))
