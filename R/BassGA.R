
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
  t <- seq(1:length(Bass))
  Horizon <- length(x)
  #                  this is the sales rate form of the Bass model
  res = diff(Bass) - (m*((exp((p+q)*t)*p*(p+q)^2) / (p*exp((p+q)*t)+q)^2))
  
  detach(data)
  
  return(-(sum(res**2)/Horizon))
  
}

#### this sets up a real-value GA using 3 parameters all from 0 to 1
#### the parameters use real numbers (so floating decimals) and passes those to
#### the nonlinear regression equation/function
#### the real-value GA requires a min and max
#### this takes a while to run

x_cum <- zoo(BM_1$Bass)
x <- diff(x_cum)

ga.BM <- ga(type='real-valued', lower=c(0,0,0), 
             upper=c(1,1,sum(x)*2), popSize=1000, maxiter=1000, names=c('innovation', 'imitation', 'max number of adopters'),
             keepBest=T, fitness = function(x) fitness(BM_1, x[1], x[2], x[3]))

#### summary of the ga with solution
ga.model <- summary(ga.BM)
ga.model

# GA settings: 
#   Type                  =  real-valued 
# Population size       =  1000 
# Number of generations =  1000 
# Elitism               =  50 
# Crossover probability =  0.8 
# Mutation probability  =  0.1 
# Search domain = 
#   innovation imitation max number of adopters
# lower          0         0               0.000000
# upper          1         1               1.970462
# 
# GA results: 
#   Iterations             = 1000 
# Fitness function value = -2.094163e-05 
# Solution = 
#   innovation imitation max number of adopters
# [1,] 0.01309831 0.4926764              0.9958072
# the estimated coefficients are close to the original: 
# p (innovation) = 0.01, q (imitation) = 0.5
