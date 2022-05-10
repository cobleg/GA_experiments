
# Objective: calibrate a Bass model using genetic algorithm
# Author: Grant Coble-Neal

library(GA)
 

#### create a function to evaluate a nonlinear regression
#### takes intercept and the two best variables to compute the predicted y_hat
#### then computes and returns the SSE for each chromosome
#### we will try to minimize the SSE like OLS does

fitness <- function(data, p, q, m){
  
  attach(data, warn.conflicts=F)
  t <- seq(1:length(Bass))
  Horizon <- length(x)
  res = Bass - (m*((exp((p+q)*t)*p*(p+q)^2) / (p*exp((p+q)*t)+q)^2))
  
    detach(data)
  
  return(-(sum(res**2)/Horizon))
  
}

#### this sets up a real-value GA using 3 parameters all from 0 to 1
#### the parameters use real numbers (so floating decimals) and passes those to
#### the nonlinear regression equation/function
#### the real-value GA requires a min and max
#### this takes a while to run

ga.BM <- ga(type='real-valued', lower=c(0,0,0), 
             upper=c(1,1,sum(BM_1$Bass)*2), popSize=1000, maxiter=1000, names=c('innovation', 'imitation', 'max number of adopters'),
             keepBest=T, fitness = function(b) fitness(BM_1, b[1], b[2], b[3]))

#### summary of the ga with solution
ga.model <- summary(ga.BM)
ga.model
