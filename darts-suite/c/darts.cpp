// Numerical approximation to Pi
// Erik Palmer 6/14/2004
//
// To Compile:
// CC darts.cpp -o darts.ex

#include <iostream>
#include <random>

constexpr int64_t NUM_TRIALS=1000000;

int main(){

  // Set up random number generator
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<> dis(0.0, 1.0); //uniform dist. [0,1]

  int64_t Ncirc = 0;
  double pi;
  double r = 1.0;
  double r2 = r*r;

  for(int64_t i=0; i<NUM_TRIALS; i++){

    double x = dis(gen);
    double y = dis(gen);

    if ((x*x + y*y) <= r2) Ncirc++;
  }

  pi = 4.0 * ((double) Ncirc / (double) NUM_TRIALS);

  std::cout << "Computing pi in serial: \n" << "For " <<  NUM_TRIALS
    << " trails, pi = " << pi << " Ncirc = " << Ncirc << "\n";

  return 0;
}


