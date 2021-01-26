This document help users testing the performance of otpmizers.

There are 6 algorithms (optimizers) implemented in this platform including
  Nomad Algorithm (NA, our proposal), 
  Particle Swarm optimization (PSO),
  Artificial Bee Colony Algorithm (ABC),
  Gravitational Search Algorithm (GSA),
  Flower Pollination Algorithm (FPA),
  and Whale optimization Algorithm (WOA).
 
CEC13 Test Function Suite (28 benchmark functions) is provided by:
Jane Jing Liang (email: liangjing@zzu.edu.cn) 

Preliminary (importing the test functions):


1. run the following command in Matlab window:
   mex cec13_func.cpp -DWINDOWS
2. Then you can use the test functions as the following example:
   f = cec13_func(x,func_num); 
   here x is a D*pop_size matrix.
   
   
 %--------------------------------------------------------------------------------
 
To the beginning of execution:


1. Initialization: Several controling parameters should be assigned.

D: dimension of all testing functions
Xmin: lower bound of search space
Xmax: upper bound of search space
pop_size: population size of optimizers, i.e., how many search agents are employed by optimizers
iter_max: max number of iterations
runs: repeating times of simulations for obtainning the statistical results


2. Selecting an optmizers to be tested:

Line 16 - line 21 are 6 different optimizers (one line for one optimizer).
Please keep only one optimizers executable and comment out the other five optimizers.

3. Then, run the 'main.m' in Matlab window


A few moment latter (seconds to minutes), 
for your selected optimziers on multiple independed runs of all the 28 functions,  
the optmization resuls are shown as a matrix in a 28x3 matrix.


Each line corresponds to a function:
first column indicates mean error, 
second column indicates standard deviations (STD), 
third column indicates time consumption.

*/
