#~             ,''''''''''''''.
#~~           /   USEPA FISH   \
#~   >~',*>  <  TOX TRANSLATOR  )
#~~           \ v1.0 "Doloris" /
#~             `..............'
#~~
#~  N. Pollesch - pollesch.nathan@epa.gov

##########################################################################
### Functions to compute nodes and weights for Gauss-Legendre quadrature
### on one interval, or on a set of subintervals within an interval
##########################################################################
### Computation functions contributed found as referenced and Developed by Ellner et al. 2016 #####

#' Computation Functions - Ellner et al., 2016 with some modifications
#'
#' This set of functions are used in the numerical discretization routines for \code{\link{SimulateModel}}
#'
#' @param L Lower bound for quadrature [float]
#' @param U Upper bound for quadrature [float]
#' @param order Number of quadrature points [integer]
require(statmod);

# Gauss-Legendre quadrature on interval (L,U)
gaussQuadInt <- function(L,U,order=7) {
  # nodes and weights on [-1,1]
  out <- gauss.quad(order); #GL is the default
  w <- out$weights; x <- out$nodes;
  weights=0.5*(U-L)*w;
  nodes=0.5*(U+L) + 0.5*(U-L)*x;
  return(list(weights=weights,nodes=nodes));
}

#gaussQuadInt(0.5,7.5,7)

### For comparison, midpoint rule
#' @describeIn gaussQuadInt Midpoint quadrature rule
#' @param m Number of points in interval from L to U
midpointInt <- function(L,U,m) {
  h=(U-L)/m; nodes=L+(1:m)*h-h/2;
  weights=rep(h,m);
  return(list(weights=weights,nodes=nodes));
}

#' @describeIn gaussQuadInt Gaussian-Legendre quadrature on subintervals of (L,U).
#' @param intervals User can specify the number of subintervals
#' @param breaks The locations of breaks between subintervals
gaussQuadSub <- function(L,U,order=7,intervals=1,breaks=NULL) {
  # nodes and weights on [-1,1]
  out <- gauss.quad(order); w <- out$weights; x <- out$nodes;

  # compute subinterval endpoints
  if(is.null(breaks)){
    h <- (U-L)/intervals;
    b <- L + (1:intervals)*h;
    a <- b-h;
  } else {
    intervals <- 1+length(breaks);
    a <- c(L,breaks);
    b <- c(breaks,U);
  }
  weights=as.vector(sapply(1:intervals,function(j) 0.5*(b[j]-a[j])*w))
  nodes=as.vector(sapply(1:intervals,function(j) 0.5*(a[j]+b[j]) + 0.5*(b[j]-a[j])*x))
  return(list(weights=weights,nodes=nodes));
}

#' @describeIn gaussQuadInt Integrate a function FUN of 2 variables using specified weights and nodes in each variable. FUN must accept two vectors as arguments and return a vector of function values
#' @param FUN Function of two variables to integrate
#' @param wts1 Weights for first variable
#' @param wts2 Weights for second variable
#' @param nodes1 Nodes for first variable
#' @param nodes2 Nodes for second variable
quad2D <- function(FUN,wts1,wts2,nodes1,nodes2) {
  X=expand.grid(nodes1,nodes2);
  W=expand.grid(wts1,wts2);
  fval=FUN(X[,1],X[,2]);
  int=sum(fval*W[,1]*W[,2]);
  return(int)
}

#' @describeIn gaussQuadInt Allometric scaling function ZToB takes (mm) to (g)
#' @param z Size in mm
#' @param alloSlope Slope parameter of allometric function
#' @param alloIntercept Intercept parameter of allometric function
ZToB<-function(z,alloIntercept,alloSlope){
  return(alloIntercept*z^alloSlope)
}

#' @describeIn gaussQuadInt Allometric scaling function BToZ takes (g) to (mm)
#' @param b mass in g
#' @param alloSlope Slope parameter of allometric function
#' @param alloIntercept Intercept parameter of allometric function
BToZ<-function(b,alloIntercept,alloSlope){
  return((b/alloIntercept)^(1/alloSlope))
}

#' @describeIn gaussQuadInt Change parameter template to data frame for computation
#' @param parameter_template A FishToxTranslator parameter template file
TemplateToDataFrame<-function(parameter_template)
{dfOut<-setNames(data.frame(matrix(NA,ncol=nrow(parameter_template))),as.character(parameter_template$id))
dfOut[1,]<-parameter_template$value
dfOut<-cbind(ordinal_date=1:365,dfOut)
return(dfOut)
}
