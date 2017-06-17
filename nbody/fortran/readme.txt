1. Compile

gfortran solar.f90 -o solar.x

or

make

2. Execute

./solar.x < init_cond.dat > evolution.trj

3. Plot planets trajectories

gnuplot plot.gnu

4. Plot Moon trajectory around the Earth

gnuplot plot_earth_moon.gnu 

5. Make animation of solar trajectories

./makeanim.sh 

display anim.gif

[Exersizes]:

1. Try to change the period from 365 days to one period of Jupiter

2. Add new functions calculationg the:
  2.1 Potential energy U

    U = m_i * m_j * g^2 / r_ij

  2.2 Kinetic energy T

    T = m_i * v_i^2 / 2

  2.3 Total energy H = T - U

3. Try to implement Verlet integration scheme
