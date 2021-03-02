#~             ,''''''''''''''.
#~~           /   USEPA FISH   \
#~   >~',*>  <  TOX TRANSLATOR  )
#~~           \ v1.0 "Doloris" /
#~             `..............'
#~~
#~  N. Pollesch - pollesch.nathan@epa.gov

#' Generate Daily Winter Survival Probabilities
#'
#' This function uses the length of the specified winter start and end dates to provide a modified daily winter surival probability
#' the creates a 'percentSurviving' probability of individuals below a specified winter cutoff to survive the entire winter
#'
#'
#' @param winterStartDate Lethal concentration for 'lc_percent' [float]
#' @param winterEndDate Percentage lethality in population for 'lc_conc' [float]
#' @param percentSurviving The fraction of individuals below the winter size threshold that survive through winter. Default is 0.0001 [float]
#' @return A time series (vector of length 365) of daily winter survival probabilities that are multiplied against background survival.  Outside of the winter start and end dates, the value is 1. [vector]
#' @export
#'
GenerateWinterSurvival<-function(winterStartDate,winterEndDate,percentSurviving=0.001){
  winterODs<-DateDuration(winterStartDate,winterEndDate)
  winterLength<-length(DateDuration(winterStartDate,winterEndDate))
  dailyWinterSurvival<-percentSurviving^(1/winterLength)
  winterSurvivalEffect<-rep(1,365)
  winterSurvivalEffect[winterODs]<-dailyWinterSurvival
return(winterSurvivalEffect)
}
