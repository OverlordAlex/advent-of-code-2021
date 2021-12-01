c     For part 1 we can simply look-behind 1
      function aoc_day1_part1()
        integer :: increases, prev
        increases = 0
        open(1, file='day1.in')
        read(1, *) prev
        do
            read(1, *, iostat=iostatus) next
            if (iostatus.ne. 0) then
              exit
            end if 
            if (next .gt. prev) then
                increases = increases + 1
            end if
            prev = next
        end do
        
        print *, increases
      end function

c     For part2 we need to realise that we're only really comparing 2 values
c       however, because I want to stream the data we will need to keep the intermediate values. But lemme tell you I'm SUPER tempted to pretend the file is a tape and do the dumb BACKSPACE thing
      program aoc_day1_part2
        integer :: increases
        integer :: buffer(3)
        increases = 0
        open(1, file='day1.in')
        read(1, *) buffer
        do
            read(1, *, iostat=iostatus) next
            if (iostatus .ne. 0) then
              exit
            end if
            if (next .gt. buffer(1)) then
                increases = increases + 1
            end if
            buffer = eoshift(buffer, 1)
            buffer(3) = next
        end do

        print *, increases
      end
