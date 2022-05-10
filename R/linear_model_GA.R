
# Objective: apply genetic algorithm to a least squares problem
# Source: https://stats.seandolinar.com/genetic-algorithm-to-minimize-ols-regression-in-r/

library(GA)
#loads an airquality dataframe
data(airquality)

#removes missing data
airquality <- na.omit(airquality) 

#### create a function to evaluate a linear regression
#### takes intercept and the two best variables to compute the predicted y_hat
#### then computes and returns the SSE for each chromosome
#### we will try to minimize the SSE like OLS does

OLS <- function(data, b0, b1, b2){
  
  attach(data, warn.conflicts=F)
  
  Y_hat <- b0  + b1*Wind + b2*Temp
  
  SSE = t(Ozone-Y_hat) %*% (Ozone-Y_hat) #matrix formulation for SSE
  
  detach(data)
  
  return(SSE)
  
}

#### this sets up a real-value GA using 3 parameters all from -100 to 100
#### the parameters use real numbers (so floating decimals) and passes those to
#### the linear regression equation/function
#### the real-value GA requires a min and max
#### this takes a while to run

ga.OLS <- ga(type='real-valued', lower=c(-100,-100, -100), 
             upper=c(100, 100, 100), popSize=500, maxiter=500, names=c('intercept', 'Wind', 'Temp'),
             keepBest=T, fitness = function(b) -OLS(airquality, b[1],b[2], b[3]))

#### summary of the ga with solution
ga.model <- summary(ga.OLS)
ga.model

#### check against the results against the typical OLS procedure
lm.model <- lm(formula= Ozone ~ Wind + Temp, data=airquality)
summary(lm.model)
lm.model$res %*% lm.model$res ### SSE.lm
-ga.model$fitness ### SSE.ga

lm.model$res %*% lm.model$res + ga.model$fitness  ### difference between OLS and GA's SSE


