! Pseudorandom number generator
! (and a bad one at that)
        module lcgenerator
          integer*8, save :: random_last = 0
          contains

          subroutine seed(s)
            integer :: s
            random_last = s
          end subroutine

          real function lcgrandom()
            integer*8, parameter :: MULTIPLIER = 1366
            integer*8, parameter :: ADDEND = 150889
            integer*8, parameter :: PMOD = 714025
  
            integer*8 :: random_next = 0
            random_next = mod((MULTIPLIER * random_last + ADDEND), PMOD)
            random_last = random_next
            lcgrandom = (1.0*random_next)/PMOD
            return
          end function
        end module lcgenerator
