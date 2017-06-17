1. Compile

gfortran -O3 harmonic.f90 -o harmonic.x

or

make

2. Execute

./harmonic.x > plot.dat

3. Plot 

gnuplot plot.gnu
