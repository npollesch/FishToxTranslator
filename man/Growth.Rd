% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Growth.R
\name{Growth}
\alias{Growth}
\title{Kernel Functions - Growth}
\usage{
Growth(
  z1,
  z,
  bt,
  pars,
  date,
  minGinc = 0.05,
  minV = 1e-05,
  CDF = T,
  muSDOut = F
)
}
\arguments{
\item{z1}{Size at the end of the timestep [float]}

\item{z}{Size at the beginning of the timestep [float]}

\item{bt}{Population biomass at beginning of timestep}

\item{pars}{Data.frame containing the date-indexed parameters [data.frame]}

\item{date}{Ordinal day to reference proper 'pars' date-indexed parameters [integer]}

\item{CDF}{TRUE/FALSE controlling output to CDF if TRUE and PDF if FALSE [boolean]}

\item{muSDOut}{TRUE/FALSE controlling output of function. If TRUE, the mean and standard deviation are output instead of the CDF or PDF.  (This is mostly used for visualization.)}
}
\value{
Probability distribution function for growth to size 'z1' from size 'z'
}
\description{
Baseline Growth:
Probabilistic Growth Transition Distribution Function.
Uses vonBertalanffy size-dependent growth to determine mean daily growth increment and a theoretical derivation (Pollesch et al, In Review)
for the associated standard deviation. The Truncated normal is used to constrain growth within the detemined lower and upper limits of size.
Density dependence controls the asymptotic size in vonBertalanffy growth, where increased biomass decreases daily asymptotic size.
}
\details{
Winter Growth:
If over-winter stress is indicated, a no growth scenario is created.
}
\concept{Kernel functions}
