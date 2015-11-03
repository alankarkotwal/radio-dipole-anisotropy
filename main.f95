program main

use SHTOOLS

real :: x,y,z
real, parameter :: flux_thresh=30e-3
integer :: lmax
real*8 :: cilm(2,121,121), grid(180,360)

do i = 1,180
    do j = 1,360
        grid(i,j) = 0
    end do
end do

open(10,file='catalog')
do while(1 == 1)
    read(10,*,END=200) x,y,z
    i = 90-floor(y)
    j = floor(x)+1
    if (z.gt.flux_thresh) then
        grid(i,j) = grid(i,j) + 1
    endif
end do

200 CONTINUE
    print *,'Read and process done!'
    close(10)
    call SHExpandDH(grid,180,cilm,lmax,sampling=2)
    print *,'lmax for expansion ',lmax
    print *,cilm


end program main
