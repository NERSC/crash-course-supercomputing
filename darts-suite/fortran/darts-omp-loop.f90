! Compute pi using OpenMP Loop
program darts
    use iso_fortran_env, only: real64
    use lcgenerator
    use omp_lib
    implicit none
    
    integer(kind=8) :: num_trials = 1000000_8
    integer(kind=8) :: ncirc = 0_8
    integer(kind=8) :: i, thread_seed, base_seed = 12345_8
    real(kind=8)    :: pi, x, y  ! Hoisted variables
    real(kind=8)    :: r = 1.0_8
    real(kind=8)    :: r2

    r2 = r * r

    !$omp parallel private(thread_seed, x, y) reduction(+:ncirc)
    !$omp loop
    do i = 1, num_trials
        thread_seed = base_seed + ((i-1) * 2_8)
        
        call lcgrandom_r(thread_seed, x)
        call lcgrandom_r(thread_seed, y)
        
        if ((x*x + y*y) <= r2) then
            ncirc = ncirc + 1_8
        end if
    end do
    !$omp end loop
    !$omp end parallel

    pi = 4.0_8 * real(ncirc, 8) / real(num_trials, 8)
    print*, '     '
    print*, '     Computing pi using OpenMP Loop:'
    print '(/,A,I0,A,F10.6,/)', '      For ', num_trials, ' trials, pi = ', pi
    print*, '     '
end program darts
