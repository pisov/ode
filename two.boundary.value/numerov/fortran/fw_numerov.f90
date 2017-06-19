!Calculating ground energy for particle in a box
!using Numerov algorithm
module functions
implicit none

!Define some global constants
!Number of mesh points
integer, parameter :: N = 1000
!Potential well half length L/2
double precision, parameter :: length = 1.d0
!Define computational box size between [-xrange,xrange]
double precision, parameter :: xrange = 5.d0
!Potential well depth V0 = 10, energy levels are: 0.81974, 3.22094, 6.94577 
double precision, parameter :: V0 = 10.d0
!Nimerical constants
double precision, parameter :: zero = 0.d0
double precision, parameter :: nearly_zero = 1.d-10
double precision, parameter :: one = 1.d0
double precision, parameter :: two = 2.d0
double precision, parameter :: five = 5.d0

contains
!Define deviation f which calculate the normalized difference
!between first derivative of left and right wave functions

function f(energy, plotid)
implicit none
double precision :: f
!input valiable - energy level
double precision, intent(in) :: energy
!input variable - flag implementig WF print if >= 0 
integer, intent(in) :: plotid

!the wave functions are deifned as left - phi_left
!right - phi_right and whole - phi
!the Numerov algorith is applied for both phi_left and phi_right
!until match point is reached, the match point is defined as 
!postion where energy = V(X)

double precision, dimension(N) :: phi_left, phi_right, phi
double precision :: h, c, x, x_left, x_right, scale, norm
integer :: i, i_match, sig, nodes, nn
character *32 :: wfname

!define boundary
x_left = -xrange 
x_right = xrange

!calculate discretization step h
h = (x_right - x_left) / (N - 1) 
c = h ** 2 / 12.d0

!calculate matching position
i_match = N
x = x_right
do while (pot(x).gt.energy)
!  write(*,*)i_match,x,pot(x)
  i_match = i_match - 1
  x = x - h
  if ( i_match.lt.1 ) then
    write(0,*)'Error could not find rigth turning point'
    stop
  end if
end do

phi(:) = zero
phi_left(:) = zero
phi_right(:) = zero


!integrate phi_left using Numerov algorithm
phi_left(1) = zero
phi_left(2) = nearly_zero
do i = 2, i_match
  x = (i - 1) * h + x_left
  phi_left(i+1) = two * (one - five * c * q(x, energy)) * phi_left(i)&
                  - (one + c * q(x-h, energy)) * phi_left(i-1)
  phi_left(i+1) = phi_left(i+1) / (one + c * q(x+h, energy))
end do 

!integrate phi_right using Numerov algorithm
phi_right(N) = zero
phi_right(N-1) = nearly_zero
do i = N - 1, i_match,-1
  x = (i - 1) * h + x_left
  phi_right(i-1) = two * (one - five * c * q(x, energy)) * phi_right(i)
  phi_right(i-1) = phi_right(i-1) - (one + c * q(x+h, energy)) * phi_right(i+1)
  phi_right(i-1) = phi_right(i-1) / (one + c * q(x-h, energy))
  phi(i-1) = phi_right(i-1)
end do

!rescale phi_left
scale = phi_right(i_match) / phi_left(i_match)
phi_left(1:i_match+1) = scale * phi_left(1:i_match+1)
phi(1:i_match) = phi_left(1:i_match)

!make F(E) continuous
sig = 1
nodes = 0
nn = 0
do i = 2, N
  if (phi(i-1)*phi(i).lt.zero) then
    nn = nn +1
  end if

  if (nn.ne.nodes) then
    nodes = nn
    sig = - sig
  end if
end do

!calculte normalized f
f = sig * (phi_right(i_match-1) - phi_right(i_match+1)&
    + phi_left(i_match+1) - phi_left(i_match-1))&
    / (2 * h *phi_right(i_match)) 

!Print WF if requested
if (plotid.ge.0) then
  !Normalize the WF
!  norm = sum(phi(:) **2)
  norm = dot_product(phi(:),phi(:)) / N
  norm = sqrt(norm)
  phi(:) = phi(:) / norm
  phi_left(:) = phi_left(:) / norm
  phi_right(:) = phi_right(:) / norm

  write(wfname,'(A2,I3.3,A4)')'wf',plotid,'.dat'
  open(10,file=wfname)
    do i = 1, N
      x = (i - 1) * h + x_left
      write(10,'(4E15.5)')x,phi_left(i),phi(i),phi_right(i)
    end do
  close(10) 
end if

end function f

!Potential energy function V(x)
function pot(x)
double precision :: pot
double precision, intent(in) :: x

if ( dabs(x).lt.length) then
  pot = zero
else
  pot = V0
end if

end function pot

!Special function q(x) = 2.0 ( E - V(x))
function q(x, e)
double precision :: q
double precision, intent(in) :: x
double precision, intent(in) :: e

q = two * (e - pot(x))

end function q

!Subroutine for root finding of function f with start point x1
!tollerance eps, xroot return the root on success flag = number of iteration
!needed or zero on error
 
subroutine secant(f, x1, eps, xroot, flag)
interface
  function f(x,pid)
    double precision :: f
    double precision, intent(in) :: x
    integer, intent(in) :: pid
  end function f
end interface
double precision, intent(inout) :: x1
double precision, intent(in) :: eps
double precision, intent(out) :: xroot
integer, intent(out) :: flag 

double precision :: df, h, x2, x3
integer :: i, pid
integer, parameter :: iter = 200

pid = -1

h = 1.d-1
x2 = x1 + h

!Iterative refining the solution 
do i=1,iter
  df = (f(x2,pid)-f(x1,pid))/(x2-x1)
  x3 = x2 - f(x2,pid)/df
! check the step. if it is improbably large - use bisection 
  if(abs(x3) > 100.d0*abs(x2)) x3 = (x2+x1)/two
! condition(s) to stop iterations)
  if(abs(f(x3,pid))<= eps) exit 
  x1 = x2
  x2 = x3 
end do
xroot=x3

!* check the convergence
if (i /= iter) then
  flag=i
  else
  flag = 0
end if

end subroutine secant

end module functions

!Main code
program numerov
use functions
implicit none

!Energy step discretization
double precision, parameter :: estep = 1.d-2
!Minimal energy
double precision, parameter :: emin = 1.d-1
!Maximal energy
double precision, parameter :: emax = 9.5d0
!Energy tollerance
double precision, parameter :: err = 1.d-6

character *16 :: scount
double precision :: e, eold, eself, tmp
integer :: flag, count, i, iter, pid

eold = emin
count = 1
pid = -1

iter = (emax - emin) / estep

write(6,*)'Energy level for particle in box found:'

do i = 0, iter
  e = emin + i * estep
  if ((f(e,pid)*f(eold,pid)).le.zero) then
    call secant(f,e,err,eself,flag)
    write(scount,'(I3.3)')count
    write(6,'(A1,A3,A3,F15.5)')'E',scount,' = ',eself
    tmp = f(eself,count)
    count = count + 1
  end if
  eold = e
end do

end program numerov
