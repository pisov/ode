module functions
implicit none
! Gravitational acceleration [kg m / s^2]
double precision, parameter :: G = 9.81e0
! Draging coeffitient [ N s / v]
double precision, parameter :: k = 4.31e-2
! Constant Pi
double precision, parameter :: Pi = 3.1415927e0
! Object mass [kg]
double precision, parameter :: mass = 0.145e0 

contains

subroutine integ(dt, t, y, ynew)
implicit none

double precision, intent(in) :: dt, t
double precision, dimension(:), intent(in) :: y
double precision, dimension(:), intent(out) :: ynew

double precision, dimension(size(y)) :: dydt

call deriv(t,y,dydt)
ynew(:) = y(:) + dt*dydt(:)

end subroutine integ

subroutine deriv(t, y, dydt)
implicit none
double precision, intent(in) :: t
double precision, dimension(:), intent(in) :: y
double precision, dimension(:), intent(out) :: dydt

dydt(1) = y(3)
dydt(2) = y(4)
dydt(3) = - k * y(3) /mass
dydt(4) = - G - k * y(4) / mass

end subroutine deriv

end module functions

program ballistic
use functions
implicit none

double precision :: dt, t, v0, theta
double precision, dimension(4) :: y, ynew, dydt

theta = 45 * Pi / 180

v0 = 44.7e0

y(1) = 0.e0
y(2) = 0.e0
y(3) = v0 * cos(theta)
y(4) = v0 * sin(theta)
t = 0.e0

write(0,*)'Please enter time step in seconds :'
read(5,*)dt

do while ( y(2) >= 0.e0 )
  write(6,'(5F17.5)')t,y(1),y(2),y(3),y(4)
  t = t + dt
  call integ(dt, t, y,ynew)
  y(:) = ynew(:)
end do 

end program ballistic

