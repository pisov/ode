module functions
implicit none
contains

function poten(y, m)
  double precision :: poten
  double precision, dimension(:), intent(in) :: y, m

  integer::i,j,n
  double precision, dimension(3) :: Ri, Rj
! Gravitational constant in AU 
  double precision, parameter :: gm=0.0172020985d0

  poten = 0.d0

  n = size(m)

  do i = 1, n - 1
     Ri(1:3) = y( (i-1)*6+1 : (i-1)*6+3 )
    do j = i + 1, n
      Rj(1:3) = y( (j-1)*6+1 : (j-1)*6+3 )
      poten = poten + gm**2 * m(i)*m(j) / sqrt(dot_product(Ri-Rj,Ri-Rj))
    end do
  end do

end function

function kinen(y, m)
  double precision :: kinen
  double precision, dimension(:), intent(in) :: y, m

  integer :: i, n
  double precision, dimension(3) :: vel

  n = size(m)

  kinen = 0.d0
  do i = 1, n
    vel(1:3) = y((i-1) * 6 + 4: i * 6)
    kinen = kinen + m(i) * dot_product(vel, vel) * 0.5d0
    !kinen = kinen + m(i) * (vel(1)**2+vel(2)**2+vel(3)**2)/2
  end do

end function

! Subroutine calculating the derivatives dydx using the input array y and
! independent variable x
! Array m keep the masses for all objects in Sun mass units

subroutine derivs(x,y,dydx,m)

  implicit none
  DOUBLE PRECISION, intent(in) :: x
  DOUBLE PRECISION, dimension(:), intent(in) :: y,m
  DOUBLE PRECISION, dimension(:), intent(out) :: dydx
! local variables
  DOUBLE PRECISION, dimension( 3 * size(m)) :: force

  integer::i,j,n
  double precision, dimension(3) :: Ri, Rj
! Gravitational constant in AU 
  double precision, parameter :: gm=0.0172020985d0

! Get the number of bodies from mass array size
  n=size(m)

! Calculate the acting force on each object
  do i=1,n
    force((i-1)*3+1:i*3)=0.d0
    Ri(1:3) = y( (i-1)*6+1 : (i-1)*6+3 )
    do j=1,n
      if (i /= j)  then
        Rj(1:3) = y( (j-1)*6+1 : (j-1)*6+3 )
        force((i-1)*3+1:i*3) = force((i-1)*3+1:i*3)+gm**2 * m(i)*m(j)*(Rj(1:3)-Ri(1:3))/(dot_product(Ri-Rj,Ri-Rj)**1.5)
      end if
    end do
  end do

! Calculate the derivatives
  do i=1,n
    dydx((i-1)*6+1  :(i-1)*6 + 3) = y((i-1)*6+4:i*6)
    dydx((i-1)*6 + 4: i*6       ) = force((i-1)*3+1:i*3)/m(i)
  end do
end subroutine derivs

subroutine vverlet(y, x, h, yout, m)
  implicit none
  DOUBLE PRECISION, DIMENSION(:), INTENT(IN) :: y, m
  DOUBLE PRECISION, INTENT(IN) :: x,h
  DOUBLE PRECISION, DIMENSION(:), INTENT(OUT) :: yout

  DOUBLE PRECISION, dimension( 3 * size(m)) :: force
  double precision, dimension(3) :: r, v, a, Ri, Rj

  double precision, parameter :: gm=0.0172020985d0
  

  integer i, j, n

  n = size(m)

  do i=1,n
    force((i-1)*3+1:i*3)=0.d0
    Ri(1:3) = y( (i-1)*6+1 : (i-1)*6+3 )
    do j=1,n
      if (i /= j)  then
        Rj(1:3) = y( (j-1)*6+1 : (j-1)*6+3 )
        force((i-1)*3+1:i*3) = force((i-1)*3+1:i*3)+gm**2 * m(i)*m(j)*(Rj(1:3)-Ri(1:3))/(dot_product(Ri-Rj,Ri-Rj)**1.5)
      end if
    end do
  end do
  
  do i = 1, n
    r(1:3) = y((i-1) * 6 + 1 : (i-1) * 6 + 3)
    v(1:3) = y((i-1) * 6 + 4 : (i-1) * 6 + 6)
    a(1:3) = force((i-1)*3+1:i*3) / m(i)

    yout((i-1) * 6 + 1 : (i-1) * 6 + 3) = r(:) + v(:) * h + a(:) * h ** 2 / 2
    yout((i-1) * 6 + 4 : (i-1) * 6 + 6) = a(:)
  end do

  do i=1,n
    force((i-1)*3+1:i*3)=0.d0
    Ri(1:3) = yout( (i-1)*6+1 : (i-1)*6+3 )
    do j=1,n
      if (i /= j)  then
        Rj(1:3) = yout( (j-1)*6+1 : (j-1)*6+3 )
        force((i-1)*3+1:i*3) = force((i-1)*3+1:i*3)+gm**2 * m(i)*m(j)*(Rj(1:3)-Ri(1:3))/(dot_product(Ri-Rj,Ri-Rj)**1.5)
      end if
    end do
  end do

  do i = 1, n
    v(1:3) = y((i-1) * 6 + 4 : (i-1) * 6 + 6)
    a(1:3) = force((i-1)*3+1:i*3) / m(i)
    yout((i-1) * 6 + 4 : (i-1) * 6 + 6) = v(:) + (a(:) + yout((i-1) * 6 + 4 : (i-1) * 6 + 6)) * h/ 2
  end do

end subroutine

! Runge Kuta order 4 subroutine
! Integrate the ODE with one step h
! use y as current solution at x
! return new value yout at x + h using derivatives dydh

SUBROUTINE rk4(y,dydx,x,h,yout,derivs, m)
        IMPLICIT NONE
        DOUBLE PRECISION, DIMENSION(:), INTENT(IN) :: y,dydx, m
        DOUBLE PRECISION, INTENT(IN) :: x,h
        DOUBLE PRECISION, DIMENSION(:), INTENT(OUT) :: yout
        INTERFACE
                SUBROUTINE derivs(x,y,dydx, m)
                IMPLICIT NONE
                DOUBLE PRECISION, INTENT(IN) :: x
                DOUBLE PRECISION, DIMENSION(:), INTENT(IN) :: y, m
                DOUBLE PRECISION, DIMENSION(:), INTENT(OUT) :: dydx
                END SUBROUTINE derivs
        END INTERFACE
        INTEGER :: ndum
        DOUBLE PRECISION :: h6,hh,xh
        DOUBLE PRECISION, DIMENSION(size(y)) :: dym,dyt,yt

        ndum=size(y)
        hh=h*0.5e0
        h6=h/6.0e0
        xh=x+hh
        yt = y(:) + hh*dydx(:)
        call derivs(xh,yt,dyt, m)
        yt = y(:) + hh*dyt(:)
        call derivs(xh,yt,dym, m)
        yt=y+h*dym
        dym(:) = dyt(:) + dym(:)
        call derivs(x+h,yt,dyt, m)
        yout(:)=y(:)+h6*(dydx(:)+dyt(:)+2.e0*dym(:))
END SUBROUTINE rk4


end module functions

! Main program integrationg the equation of motion of n celestial obejects
! using classical Newtonian equation of motion
! the inital conditions are read from standard input:
! period [Days]
! h - integration step [Days]
! n - number of celestial bodies
! x y z Vx Vy Vz mass - coordinates and velocities of each body in distance is Earth disance AU units 
! velocity is in AU/day and mass in Sun masses

program runge_kutta 
use functions

implicit none
double precision :: h, x, period, wrtout
double precision, allocatable, dimension(:) :: y,ynew, dydx, m
character (len=20) :: frmt
double precision :: Ep, Ek, Etot

integer :: i,n,j,maxit


! Read the total integration period
read(*,*)period

! Read the integration step
read(*,*)h
if ( h <= 0.d0 .and. h >= 1.d0) then
  print *, 'wrong h'
  stop
end if

read(*,*)wrtout

! Read the number of objects 
read(*,*)n

! Allocate required memory for working arrays based on - n
allocate(y(6 * n))
allocate(ynew(6 * n))
allocate(dydx(6 * n))
allocate(m(n))

! Read inital positions, velocity and mass for each object
do i=1,n
  read(*,*)y((i-1)*6+1),y((i-1)*6+2),y((i-1)*6+3),y((i-1)*6+4),y((i-1)*6+5),y(i*6),m(i)
end do

! Calculate iteration steps
maxit=period/h

! Prepare output format string
write(frmt, '(a, I4, a)') '(',6*n + 4,'E25.15)'
do i = 1, maxit
  x=x+h

  !call derivs(x, y, dydx, m)
  !call rk4(y, dydx, x, h, ynew, derivs, m)
  call vverlet(y, x, h, ynew, m)
  y(:) = ynew(:)
! Print data out
  if ( mod(i * h, wrtout) == 0) then
    Ep = poten(y, m)
    Ek = kinen(y, m)
    Etot = Ek - Ep
    write(*, frmt)x,(y(j),j=1,6*n),Ep, Ek, Etot
  end if
end do

! Deallocate the arrays
deallocate(y)
deallocate(ynew)
deallocate(dydx)
deallocate(m)

end program runge_kutta

