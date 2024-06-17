// Numerical approximation to Pi with MPI
// Erik Palmer 6/14/2004
//
// To Compile:
// CC darts-mpi.cpp -o darts-mpi.ex

#include <iostream>
#include <random>
#include <mpi.h>

constexpr int64_t NUM_TRIALS=1000000;

int main(int argc, char *argv[]){

  MPI_Init(&argc,&argv);

  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Status status;
  int manager = 0;
  int64_t my_trials = (int64_t) (NUM_TRIALS / size);

  // Set up random number generator
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_real_distribution<> dis(0.0, 1.0); //uniform dist. [0,1]

  int64_t Ncirc = 0;
  int64_t temp = 0;
  double pi;
  double r = 1.0;
  double r2 = r*r;

  for(int64_t i=0; i<my_trials; i++){

    double x = dis(gen);
    double y = dis(gen);

    if ((x*x + y*y) <= r2) Ncirc++;
  }

  if (rank == manager){
    for(int j=1; j<size; j++){
      MPI_Recv(&temp, 1, MPI_INT64_T, j, j, MPI_COMM_WORLD, &status);
      Ncirc += temp;
    }

    pi = 4.0 * ((double) Ncirc / (double) NUM_TRIALS);

    std::cout << "Computing pi in serial: \n" << "For " <<  NUM_TRIALS
      << " trails, pi = " << pi << " Ncirc = " << Ncirc << "\n";

  } else {
    MPI_Send(&Ncirc, 1, MPI_INT64_T, manager, rank, MPI_COMM_WORLD);
  }

  MPI_Finalize();
  return 0;
}
