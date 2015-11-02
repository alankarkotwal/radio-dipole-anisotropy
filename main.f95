program main

real :: x,y,z
integer, dimension(180,360) :: grid
real, parameter :: flux_thresh=30

do i = 1,180
    do j = 1,360
        grid(i,j) = 0
    end do
end do

open(10,file='catalog')
do while(1 == 1)
    read(10,*,END=200) x,y,z
    i = floor(y)+91
    j = floor(x)+1
    grid(i,j) = grid(i,j) + 1
end do

200 CONTINUE
    print *,'Read and process done!'
    close(10)

print *,grid

end program main
