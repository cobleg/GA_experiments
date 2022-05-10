

# Objective: create a Bass Model of new technology adoption
# Author: Grant Coble-Neal
# Reference: https://en.wikipedia.org/wiki/Bass_diffusion_model#:~:text=The%20Bass%20model%20or%20Bass,of%20a%20new%20product%20interact.

BASS <- function(p, q){
  t <- seq(1:20)
  # this is the cumulative reduced-form solution (i.e. a function of parameters and time)
  F_t <- (1-exp(-(p+q)*t))/(1+q/p*exp(-(p+q)*t)) 
  return(F_t)
}

BM_1 <- data.frame( Bass = BASS(0.01, 0.5))

plot(BM_1, type = "l", xlab = "Time", ylab = "Proportion of adopters", main = "Bass Model")
