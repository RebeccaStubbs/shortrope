jnll_poisson<-function(data,parameters){
  # For the poisson, there is only 1 parameter-- lambda, which
  # is the expected count. This has to be positive, so we'll exponentiate it.
  
  lambda<-exp(parameters["log_lambda"])
  
  vector_of_likelihoods<-dpois(data,lambda,log=TRUE) 
  jnll<- -1*sum(vector_of_likelihoods)
  return(jnll)
}


simulated_data[,sim_pois:=rpois(10000,10)]
# Generating a column ("sim_poisson") that has 10000 observations 
# pulled from a poisson distribution with a lambda (expected count) of 10.

Opt_poisson <- optim(par=list("log_lambda"=0), 
                     fn=jnll_poisson,
                     data=simulated_data$sim_poisson)

poisson_params<-get_params(Opt_poisson)
poisson_params