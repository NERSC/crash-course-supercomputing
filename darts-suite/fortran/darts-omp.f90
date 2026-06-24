! Compute pi using OpenMP
program darts
    use lcgenerator
    use omp_lib
    implicit none
    
    integer(kind=8) :: num_trials = 1000000_8
    integer(kind=8) :: ncirc = 0_8
    integer(kind=8) :: base_seed = 12345_8
    real(kind=8)    :: pi
    real(kind=8)    :: r = 1.0_8
    real(kind=8)    :: r2

    ! Hoisted thread-local variables
    integer(kind=8) :: i, global_i, thread_seed, my_trials
    real(kind=8)    :: x, y
    integer         :: tid, total_threads

    r2 = r * r

    !$omp parallel private(i, global_i, thread_seed, my_trials, x, y, tid, total_threads) reduction(+:ncirc)
    
    tid = omp_get_thread_num()
    total_threads = omp_get_num_threads()
    my_trials = num_trials / int(total_threads, 8)

    do i = 1, my_trials
        global_i = int(tid, 8) + ((i-1) * int(total_threads, 8))
        thread_seed = base_seed + (global_i * 2_8)
        
        call lcgrandom_r(thread_seed, x)
        call lcgrandom_r(thread_seed, y)
        
        if ((x*x + y*y) <= r2) then
            ncirc = ncirc + 1_8
        end if
    end do
    
    !$omp end parallel

    pi = 4.0_8 * real(ncirc, 8) / real(num_trials, 8)
    print*, '     '
    print*, '     Computing pi using OpenMP:'
    print '(/,A,I0,A,F10.6,/)', '      For ', num_trials, ' trials, pi = ', pi
    print*, '     '
end program darts
