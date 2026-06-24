! Compute pi using six basic MPI subroutines
program darts
    use lcgenerator
    use mpi_f08
    implicit none
    
    integer(kind=8)   :: num_trials = 1000000_8
    integer(kind=8)   :: local_ncirc = 0_8
    integer(kind=8)   :: total_ncirc = 0_8
    integer(kind=8)   :: received_ncirc
    integer(kind=8)   :: i, thread_seed, base_seed = 12345_8, my_trials
    real(kind=8)      :: pi, x, y
    real(kind=8)      :: r = 1.0_8
    real(kind=8)      :: r2
    type(MPI_Status)  :: status
    integer           :: rank, size, manager = 0, source
    integer           :: ierr

    call MPI_Init(ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)
    call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

    r2 = r * r
    my_trials = num_trials / int(size, 8)

    ! Every rank executes its independent Leapfrog stride
    do i = 1, my_trials
        thread_seed = base_seed + (int(rank, 8) + ((i-1) * int(size, 8))) * 2_8
        
        call lcgrandom_r(thread_seed, x)
        call lcgrandom_r(thread_seed, y)
        
        if ((x*x + y*y) <= r2) then
            local_ncirc = local_ncirc + 1_8
        end if
    end do

    if (rank == manager) then
        total_ncirc = local_ncirc
        
        do source = 1, size - 1
            call MPI_Recv(received_ncirc, 1, MPI_INTEGER8, source, 0, MPI_COMM_WORLD, status, ierr)
            total_ncirc = total_ncirc + received_ncirc
        end do
        
        pi = 4.0_8 * real(total_ncirc, 8) / real(num_trials, 8)
        print*, '     '
        print*, '     Computing pi using six basic MPI functions:'
        print '(/,A,I0,A,F10.6,/)', '      For ', num_trials, ' trials, pi = ', pi
        print*, '     '  

    else
        call MPI_Send(local_ncirc, 1, MPI_INTEGER8, manager, 0, MPI_COMM_WORLD, ierr)
    end if

    call MPI_Finalize(ierr)
end program 
