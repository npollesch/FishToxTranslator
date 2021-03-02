#~             ,''''''''''''''.
#~~           /   USEPA FISH   \
#~   >~',*>  <  TOX TRANSLATOR  )
#~~           \ v1.0 "Doloris" /
#~             `..............'
#~~
#~  N. Pollesch - pollesch.nathan@epa.gov


#' Kernel Functions - Growth
#'
#' Baseline Growth:
#' Probabilistic Growth Transition Distribution Function.
#' Uses vonBertalanffy size-dependent growth to determine mean daily growth increment and a theoretical derivation (Pollesch et al, In Review)
#' for the associated standard deviation. The Truncated normal is used to constrain growth within the detemined lower and upper limits of size.
#' Density dependence controls the asymptotic size in vonBertalanffy growth, where increased biomass decreases daily asymptotic size.
#'
#' Winter Growth:
#' If over-winter stress is indicated, a no growth scenario is created.
#'
#' @param z Size at the beginning of the timestep [float]
#' @param z1 Size at the end of the timestep [float]
#' @param bt Population biomass at beginning of timestep
#' @param pars Data.frame containing the date-indexed parameters [data.frame]
#' @param date Ordinal day to reference proper 'pars' date-indexed parameters [integer]
#' @param CDF TRUE/FALSE controlling output to CDF if TRUE and PDF if FALSE [boolean]
#' @param muSDOut TRUE/FALSE controlling output of function. If TRUE, the mean and standard deviation are output instead of the CDF or PDF.  (This is mostly used for visualization.)
#' @return Probability distribution function for growth to size 'z1' from size 'z'
#' @export
#' @family Kernel functions

Growth<-function (z1, z, bt, pars, date, minGinc=0.05,minV=0.00001, CDF = T, muSDOut = F)
{

  if(pars$is_density_dependent[date]){
    zInfD<-pars$z_inf[date]*exp(-pars$dd_g[date]*bt)+z*(1-exp(-pars$dd_g[date]*bt))}
  else(zInfD<-pars$z_inf[date])
  mu.pre <- ifelse(zInfD - (zInfD - z) * exp(-(pars$k_g[date]))-z < minGinc,z+minGinc,zInfD - (zInfD - z) * exp(-(pars$k_g[date])))

  #provides percent decrease in growth effects due to exposure
  if(exists("are_growth_effects",where=pars)){
    if(pars$are_growth_effects[date]){
      mu.pre <- ifelse(zInfD - (zInfD - z) * exp(-(pars$k_g[date]*pars$growth_percent[date]))-z < minGinc,z+minGinc,zInfD - (zInfD - z) * exp(-(pars$k_g[date]*pars$growth_percent[date])))}}

  if(exists("is_winter",where=pars)){
    mu <- (1 - pars$is_winter[date]) * mu.pre + pars$is_winter[date]*z}
  else(mu<-mu.pre)
  #mu<-ifelse(mu.pre<0.2,0.2,mu.pre)
  sig.pre <- ifelse(((zInfD - mu)^2) * (pars$var_k_g[date]) <
                      minV, minV, ((zInfD - mu)^2) * (pars$var_k_g[date]))
  if(exists("is_winter",where=pars)){
    sig <- (1 - pars$is_winter[date]) * sig.pre}
  else(sig<-sig.pre)

  if (CDF) {
    p.den.grow <- ptruncnorm(z1, a = pars$z_hatch[[date]] , b = pars$z_inf[[date]], mean = mu,
                             sd = sqrt(sig))
  }
  if (!CDF) {
    p.den.grow <- dtruncnorm(z1, a = pars$z_hatch[[date]], b = pars$z_inf[[date]], mean = mu,
                             sd = sqrt(sig))
  }
  if (muSDOut) {
    return(cbind(mu, sqrt(sig)))
  }
  if (!muSDOut) {
    return(p.den.grow)
  }
}


# ## Can be used to create associated parameter data file for P. promelas
#
# Growth.parameters.p.promelas<-c(
#   z_inf=74, Lab study
#   b_inf=7.4*10^5 # Max biomass - Based on pond estimate from Payer 1977 of 750kg production per year
#   dd_g=1 # Growth Saturation rate - Chosen without fitting
#   k_g=0.009, Lab
#   var_k_g=5.94*(10^(-7)), Lab study
#   is_winter=0
# )
#
# ##Creates an RData file to store the parameters
# devtools::use_data(Growth.parameters.p.promelas,overwrite=T)
