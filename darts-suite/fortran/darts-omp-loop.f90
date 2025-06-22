! Compute pi using OpenMP "!$OMP loop"

! Written by Helen He, June 2024
! In this code, we are not using the pseudorandom number generator used in other codes,
! instead we use a complete random number generator from Fortran intrinsic randon_number()
! so we do not need to use an OMP critial region (which is not allowed to nest under omp loop)
! to reproduce the randon seeds.  
! so the final pi value is not bit-for-bit from other codes
! Also, it gives a different pi value every time it runs

! Now, we compute pi
program darts
   implicit none
   integer*8 :: num_trials = 1000000, i = 0, Ncirc = 0
   real :: pi = 0.0, x = 0.0, y = 0.0, r = 1.0
   real :: r2 = 0.0
   r2 = r*r

!$OMP parallel private(x,y) reduction(+:Ncirc)
!$OMP loop
    do i = 1, num_trials
       call random_number(x)
       call random_number(y)
       if ((x*x + y*y) .le. r2) then
          Ncirc = Ncirc+1
       end if
    end do
!$OMP end loop
!$OMP end parallel

    pi = 4.0*((1.0*Ncirc)/(1.0*num_trials))
    print*, '     '
    print*, '     Computing pi using OpenMP:         '
    print*, '     For ', num_trials, ' trials, pi = ', pi
    print*, '     '

end program
