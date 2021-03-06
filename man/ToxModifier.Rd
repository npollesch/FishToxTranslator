% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ToxModifier.R
\name{ToxModifier}
\alias{ToxModifier}
\title{Size-dependent Toxicity Modifier}
\usage{
ToxModifier(
  z,
  toxModType,
  toxMultU,
  toxMultL,
  upperBound,
  lowerBound,
  zPartition,
  toxModVec
)
}
\arguments{
\item{z}{Size at the beginning of the timestep [float or vector]}

\item{toxModType}{String to switch between the two current options, "linear", or "step"}

\item{toxMultU}{Toxicity multiplier at upper bound size 'upperBound' [float]}

\item{toxMultL}{Toxicity multiplier at lower bound size 'lowerBound' [float]}

\item{upperBound}{Upper size limit in the model [float]}

\item{lowerBound}{Lower size limit in the model [float]}

\item{zPartition}{Size partition of the size range.  Uses 'stepfun' from 'stats' package, please see help for additional details on using 'stepfun' [vector]}

\item{toxModVec}{Multipliers for each component of 'zPartition' vector [vector]}
}
\value{
Toxicity multiplier as a function of size [float]
}
\description{
Two built in functions to modify survival dercrement based on either a linear interpolation of toxicity effects or a step function for size classes
}
\details{
Linear:
Linear transition between largest and smallest classes
\deqn{ToxModifier(z) =((toxMultU-toxMultL)/(upperBound-lowerBound))*(z-upperBound)+toxMultU}

Step:
Step function to assign discrete multipliers to size classes
\deqn{ToxModifier(z) = \sum_{i=0}^{n}{mVec_i * \textbf{1}_{\zPartition_{i}}(z)}}
}
