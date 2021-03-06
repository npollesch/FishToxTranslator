% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SimulateModel.R
\name{SimulateModel}
\alias{SimulateModel}
\title{Simulate Model}
\usage{
SimulateModel(
  par,
  n_0 = 100,
  z_t_0 = NA,
  growthSurvivalComponent = GrowthSurvivalKernel,
  reproductionComponent = ReproductionKernel,
  dates = 1:365,
  num_size_classes = 100,
  solver_order = 3,
  allOut = F
)
}
\arguments{
\item{par}{The data.frame that contains date-indexed kernel function parameters for the scenario being modeled [data.frame]}

\item{n_0}{Intial number of individuals in the system to simulate - assumed uniform distribution of these individuals across the size classes and size range [float]}

\item{z_t_0}{Initial distribution of sizes (not normalized) - If z_t_0 is specified it will overwrite values of n_0 specified [vector, 1 x num_size_classes]}

\item{growthSurvivalComponent}{Kernel component representing adult growth and survival [function(z1,z,bt,pars,date)]}

\item{reproductionComponent}{Kernel component representing reproduction [function(z1,z,bt,pars,date)]}

\item{dates}{Ordinal dates to create discretized kernel - default is c(1,...,365) [vector]}

\item{num_size_classes}{The number of classes to discretize to [integer]}

\item{solver_order}{Order for the gaussian quadrature rule used in numerical integration [integer]}
}
\value{
A list is returned without outputs that include daily size vectors [1 x num_size_classes], population [float], and biomass [float]. A cumulative transition kernel is also output [matrix, num_size_classes x num_size_classes]. If 'allOut=T', daily transition kernels are output in addition to previous outputs [matrix, num_size_classes x num_size_classes].
}
\description{
Uses numerical integration to create a discretized transition kernel and uses the kernel to project daily size distributions and population biomass
}
\note{
Any densities used in the kernels must use the CDF as opposed to the PDF due to the numerical integration technique being utilized. See Ellner et al., 2016 p 171
}
