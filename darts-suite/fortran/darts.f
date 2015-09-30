! Compute pi in serial
! First, the pseudorandom number generator
        real function lcgrandom()
          integer*8, parameter :: MULTIPLIER = 1366
          integer*8, parameter :: ADDEND = 150889
          integer*8, parameter :: PMOD = 714025
          integer*8, save :: random_last = 0

          integer*8 :: random_next = 0
          random_next = mod((MULTIPLIER * random_last + ADDEND), PMOD)
          random_last = random_next
          lcgrandom = (1.0*random_next)/PMOD
          return
        end

! Now, we compute pi
        program darts
          implicit none
          integer*8 :: num_trials = 1000000, i = 0, Ncirc = 0
          real :: pi = 0.0, x = 0.0, y = 0.0, r = 1.0
          real :: r2 = 0.0
          real :: lcgrandom
          r2 = r*r

          do i = 1, num_trials
            x = lcgrandom()
            y = lcgrandom()
            if ((x*x + y*y) .le. r2) then
              Ncirc = Ncirc+1
            end if
          end do

          pi = 4.0*((1.0*Ncirc)/(1.0*num_trials))
          print*, '	'
          print*, '	Computing pi in serial:		'
          print*, ' 	For ', num_trials, ' trials, pi = ', pi
          print*, '	'

        end

