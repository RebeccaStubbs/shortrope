
#include <TMB.hpp>
template<class Type>
Type objective_function<Type>::operator() () 
{ //Always include everything above this line

  // Data
  DATA_VECTOR( y_i ); 

  // Parameters
  PARAMETER( mean );
  PARAMETER( log_sd );

  // Objective Function
  Type sd = exp(log_sd);
  Type jnll = 0;
  int n_data = y_i.size();

  // Probability of data conditional on parameter values
  for( int i=0; i<n_data; i++){ 
     jnll -= dnorm( y_i(i), mean, sd, true );
  }
  
  return jnll;
}



#include <TMB.hpp>
template<class Type>
Type objective_function<Type>::operator() () 
{ //apparently we just always put everything
  // Data
  DATA_VECTOR( y_i ); 

  // Parameters
  PARAMETER( mean );
  PARAMETER( log_sd );

  // Objective function
  Type sd = exp(log_sd);
  Type jnll = 0; //jnll: joint negative log liklihood. Setting to zero to begin with.
  int n_data = y_i.size(); // int= integer n_data, y_i.size figures out the length of that vector.

  // Probability of data conditional on fixed effect values
  for( int i=0; i<n_data; i++){ //loop in C++
    //note: it needs to be starting at 0, and use i<n_data, which then stops 1 before the length of n_data-- this is because
    // R indexes from 1 and C++ indexes from 0.
    jnll -= dnorm( y_i(i), mean, sd, true ); //-= every time you go through the loop, you add in the negative of the right hand side.
  // also could be written as:
  // jnll = jnll-dnorm( y_i(i), mean, sd, true );
  }

  // Reporting
  return jnll;
}


//Note: R indexes from 1 to n, while C++ indexes from 0.
