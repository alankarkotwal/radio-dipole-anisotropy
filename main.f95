program main

use SHTOOLS

real :: x,y,z
real, parameter :: flux_thresh=30e-3
integer :: lmax,nlat,nlong
real*8 :: cilm(2,121,121), grid(181,361), cilm2(2,121,121), grid2(181,361)

!empty the shit out of these
do i = 1,2
    do j = 1,121
        do k = 1,121
            cilm2(i,j,k) = 0
        end do
    end do
end do

do i = 1,181
    do j = 1,361
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
    !print *,grid
    print *,'Read and process done!'
    close(10)
    call SHExpandDH(grid,180,cilm,lmax,sampling=2)
    print *,'lmax for expansion ',lmax
    do l = 1,5,1
        print *, 'The coeffeceients corresponding to l=',l-1,'are'
        do k = 1,l,1
            print *,cilm(1,l,k),cilm(2,l,k)
        end do
    end do
    !put a dipole
    cilm2(1,1,1)= 0
    cilm2(1,2,1)= cilm(1,2,1)
    cilm2(1,2,2)= cilm(1,2,2)
    cilm2(2,2,2)= cilm(2,2,2)
    lmax = 89
    call MakeGrid2D(grid2, cilm2, lmax, 1.0d0,nlat,nlong)
    print *,'maximum at ',maxloc(grid2)
    print *,'minimum at ',minloc(grid2)


end program main
