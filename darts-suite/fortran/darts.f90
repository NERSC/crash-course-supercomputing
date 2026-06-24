! Compute pi in serial
program darts
    use lcgenerator ! Assumes module containing lcgrandom_r
    implicit none
    
    integer(kind=8) :: num_trials = 1000000, Ncirc = 0
    integer(kind=8) :: i, thread_seed, base_seed = 12345
    real*8    :: pi, x, y, r = 1.0
    real*8    :: r2

    r2 = r * r

    do i = 0, num_trials - 1
        thread_seed = base_seed + (i * 2)
        
        call lcgrandom_r(thread_seed,x)
        call lcgrandom_r(thread_seed,y)
        
        if ((x*x + y*y) <= r2) then
            ncirc = ncirc + 1
        end if
    end do

   pi = 4.0 * real(ncirc, 8) / real(num_trials, 8)

    print*, '	'
    print*, '	Computing pi in serial:		'
    print '(/,A,I0,A,F10.6,/)', '        For ', num_trials, ' trials, pi = ', pi
    print*, '	'

end program darts
