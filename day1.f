      program aoc_day1
        integer :: increases, prev
        increases = 0
        open(1, file='day1.in')
        read(1, *) prev
        do
            read(1, *, iostat=iostatus) next
            if (iostatus /= 0) then
              exit
            end if 
            if (next > prev) then
                increases = increases + 1
            end if
            prev = next
        end do
        
        print *, increases
      end
