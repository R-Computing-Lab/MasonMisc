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
#' @examples
#'
#' syndata(cov.mat=matrix(c(0.683,0.388,0.438,0.442,0.222,0.419,0.395,0.420,0.298,0.337,
#' 0.388,1.012,0.481,0.599,0.242,0.519,0.409,0.482,0.251,0.308,
#' 0.438,0.481,1.836,1.021,0.686,0.511,0.407,0.811,0.652,0.675,
#' 0.442,0.599,1.021,1.208,0.655,0.776,0.662,0.664,0.514,0.491,
#' 0.222,0.242,0.686,0.655,0.849,0.566,0.509,0.440,0.427,0.439,
#' 0.419,0.519,0.511,0.776,0.566,0.738,0.615,0.445,0.344,0.388,
#' 0.395,0.409,0.407,0.662,0.509,0.615,0.663,0.433,0.401,0.478,
#' 0.420,0.482,0.811,0.664,0.440,0.445,0.433,0.911,0.532,0.436,
#' 0.298,0.251,0.652,0.514,0.427,0.344,0.401,0.532,0.636,0.451,
#' 0.337,0.308,0.675,0.491,0.439,0.388,0.478,0.436,0.451,0.720),byrow=TRUE, nrow=10),
#' means=c(1.9,2,3,2.2,2,1.9,1.8,1.9,1.8,1.9),
#' n=300,
#' varnames=c("senseofcontrol_t1","senseofcontrol_t2",
#'            "senseofcontrol_t3","senseofcontrol_t4",
#'            "senseofcontrol_t5","senseofcontrol_t6",
#'            "senseofcontrol_t7","senseofcontrol_t8",
#'            "senseofcontrol_t9","senseofcontrol_t10")
#' )

syndata <- function(df=NULL,
                    n=300,
                    cov.mat=NULL,
                    means=NULL,
                    varnames=NULL,
                    ...) {
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


