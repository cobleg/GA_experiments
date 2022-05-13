


# Objective: calibrate a Bass model using genetic algorithm
# Author: Grant Coble-Neal
# Reference: Rajkumar Venkatesan, V. Kumar (2002). A genetic algorithms approach to growth phase forecasting of wireless subscribers, International Journal of Forecasting, Volume 18, Issue 4, Pages 625-646, ISSN 0169-2070, https://doi.org/10.1016/S0169-2070(02)00070-5.
library(GA)
library(zoo)

#### create a function to evaluate a nonlinear regression
#### takes intercept and the two best variables to compute the predicted y_hat
#### then computes and returns the SSE for each chromosome
#### we will try to minimize the SSE like OLS does

fitness <- function(data, p, q, m){
  
  attach(data, warn.conflicts=F)
  time <- seq(1:length(Sales))
  Horizon <- length(Sales)
  #                  this is the sales rate form of the Bass model
  res = Sales - ((p+q)^2/p)*exp(-(p+q)*time) / (1 + (q/p)*exp(-(p+q)*time)^2)
  
  detach(data)
  
  return(-(sum(res**2)/Horizon)) # normalising on horizon
  
}

#### this sets up a real-value GA using 3 parameters all from 0 to 1
#### the parameters use real numbers (so floating decimals) and passes those to
#### the nonlinear regression equation/function
#### the real-value GA requires a min and max
#### this takes a while to run

ga.BM <- ga(type='real-valued', lower=c(0,0), pmutation = 0.2,
            upper=c(1,1), popSize=2000, maxiter=100, names=c('innovation', 'imitation'),
            keepBest=T, fitness = function(x) fitness(BM_sales.1, x[1], x[2]))

#### summary of the ga with solution
ga.model <- summary(ga.BM)
ga.model
plot(ga.BM)
