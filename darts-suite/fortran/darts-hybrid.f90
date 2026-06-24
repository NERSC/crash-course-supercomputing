! Compute pi using hybrid MPI/OpenMP
program darts
    use lcgenerator
    use mpi_f08
    use omp_lib
    implicit none
    
    integer(kind=8)   :: num_trials = 1000000_8
    integer(kind=8)   :: total_ncirc = 0_8
    integer(kind=8)   :: base_seed = 12345_8
    integer(kind=8)   :: trials_per_rank, trials_per_thread, local_rank_ncirc = 0_8
    real(kind=8)      :: pi
    real(kind=8)      :: r = 1.0_8
    real(kind=8)      :: r2
    integer           :: rank, size, manager = 0
    integer           :: total_threads = 1
    integer           :: provided, ierr

    integer(kind=8)   :: i, global_i, thread_seed
    real(kind=8)      :: x, y
    integer           :: tid

    call MPI_Init_thread(MPI_THREAD_FUNNELED, provided, ierr)
    call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)
    call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

    r2 = r * r
    call MPI_Bcast(num_trials, 1, MPI_INTEGER8, manager, MPI_COMM_WORLD, ierr)

    !$omp parallel
    !$omp single
    total_threads = omp_get_num_threads()
    !$omp end single
    !$omp end parallel

    trials_per_rank = num_trials / int(size, 8)
    trials_per_thread = trials_per_rank / int(total_threads, 8)

    !$omp parallel private(i, global_i, thread_seed, x, y, tid) reduction(+:local_rank_ncirc)
    
    tid = omp_get_thread_num()

    do i = 0, trials_per_thread - 1
        global_i = (int(rank, 8) * int(total_threads, 8)) + int(tid, 8) + &
                   (i * (int(size, 8) * int(total_threads, 8)))
        
        thread_seed = base_seed + (global_i * 2_8)
        
        call lcgrandom_r(thread_seed, x)
        call lcgrandom_r(thread_seed, y)
        
        if ((x*x + y*y) <= r2) then
            local_rank_ncirc = local_rank_ncirc + 1_8
        end if
    end do
    
    !$omp end parallel

    call MPI_Reduce(local_rank_ncirc, total_ncirc, 1, MPI_INTEGER8, MPI_SUM, manager, MPI_COMM_WORLD, ierr)

    if (rank == manager) then
        pi = 4.0_8 * real(total_ncirc, 8) / real(num_trials, 8)
        print*, '     '
        print*, '     Computing pi using hybrid MPI/OpenMP:'
        print '(/,A,I0,A,F10.6,/)', '      For ', num_trials, ' trials, pi = ', pi
        print*, '     '
    end if

    call MPI_Finalize(ierr)
end program
