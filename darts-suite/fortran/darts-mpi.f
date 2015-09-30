! Compute pi using six basic MPI subroutines
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

          if (rank .eq. manager) then
            do j = 1, np-1
              call MPI_Recv(temp, 1, MPI_INTEGER, j, j, 
     &          MPI_COMM_WORLD, mpistatus, mpierr)
              Ncirc = Ncirc + temp
            end do
            pi = 4.0*((1.0*Ncirc)/(1.0*num_trials))
            print*, '     '
            print*, '     Computing pi using six basic MPI functions:'
            print*, '     For ', num_trials, ' trials, pi = ', pi
            print*, '     '
          else
            call MPI_Send(Ncirc, 1, MPI_INTEGER, manager, rank, 
     &        MPI_COMM_WORLD, mpierr) 
          end if
          call MPI_Finalize(mpierr)
        end

