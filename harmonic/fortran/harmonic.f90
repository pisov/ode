program harmonic
implicit none


! Define coupling matrix
double precision, dimension(2,2) :: cm

double precision, dimension(2) :: rm, r, v, a, rnew, vnew, anew
double precision :: t, dt, mass, k, tmax


cm = reshape((/1.d0, 0.d0, 0.d0, 1.d0/), shape(cm))

write(0,*)'Please enter the integration step dt ='
read(5,*)dt

if (dt .gt. 1.d0) then
  write(0,*)'The integration step should be less than 1.'
  stop 
end if

t = 0.d0
tmax = 10.d0
mass = 1.d0
k = 1.d0

r(1) = 1.d0
r(2) = 0.5d0
v(1) = 0.d0
v(2) = 0.5d0

do while ( t .le. tmax)
  write(6,'(5F17.5)')t,r(1),r(2),v(1),v(2)
  rm(:) = matmul(cm, r)
  a(:) = - k * rm(:) / mass
  rnew(:) = r(:) + v(:) * dt + 0.5d0 * a(:) * dt ** 2
  anew(:) = - k * rnew(:) / mass
  vnew(:) = v(:) + 0.5d0 * dt * (a(:) + anew(:))
  t = t + dt
  v(:) = vnew(:)
  r(:) = rnew(:)
end do

end program harmonic
