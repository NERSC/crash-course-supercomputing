! Thread-safe pseudorandom number generator
! (and a bad one at that)
module lcgenerator
    implicit none
    private
    
    public :: lcgrandom_r

contains
    ! Use pure subroutine to allow modifying random_last seed 
    ! while maintaining thread-safety
    pure subroutine lcgrandom_r(random_last, rand_val)
        integer(kind=8), intent(inout) :: random_last
        real(kind=8), intent(out)      :: rand_val
        
        integer(kind=8), parameter :: multiplier = 1366_8
        integer(kind=8), parameter :: addend     = 150889_8
        integer(kind=8), parameter :: pmod       = 714025_8
        
        integer(kind=8) :: random_next
        
        random_next = mod((multiplier * random_last + addend), pmod)
        random_last = random_next
        rand_val = real(random_next, 8) / real(pmod, 8)
    end subroutine lcgrandom_r

end module lcgenerator
