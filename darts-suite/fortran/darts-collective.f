! Compute pi using MPI collectives
        program darts
          use lcgenerator
          implicit none
          include 'mpif.h'
          integer :: num_trials = 1000000, i = 0, Ncirc = 0
          real :: pi = 0.0, x = 0.0, y = 0.0, r = 1.0
          real :: r2 = 0.0

          integer :: rank, np, manager = 0
          integer :: mpistatus, mpierr, j
          integer :: my_trials, temp

          call MPI_Init(mpierr)
          call MPI_Comm_size(MPI_COMM_WORLD, np, mpierr)
          call MPI_Comm_rank(MPI_COMM_WORLD, rank, mpierr)
          r2 = r*r
          my_trials = num_trials/np
          if (mod(num_trials, np) .gt. rank) then
            my_trials = my_trials+1
          end if
          call seed(rank)

          do i = 1, my_trials
            x = lcgrandom()
            y = lcgrandom()
            if ((x*x + y*y) .le. r2) then
              Ncirc = Ncirc+1
            end if
          end do

          call MPI_Reduce(Ncirc, temp, 1, MPI_INTEGER, MPI_SUM,
     &      manager, MPI_COMM_WORLD, mpierr)

          if (rank .eq. manager) then
              Ncirc = temp
              pi = 4.0*((1.0*Ncirc)/(1.0*num_trials))
              print*, '     '
              print*, '     Computing pi using MPI collectives:'
              print*, '     For ', num_trials, ' trials, pi = ', pi
              print*, '     '
          end if
          call MPI_Finalize(mpierr)
        end

