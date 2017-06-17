1. Compile code

gcc -O3 ballistic.c -lm -o ballistic.x

or

make

2. Execute and eneter time step dt for example dt = 0.1

./ballistic.x > plot.dat


3. Plot the trajectory

gnuplot plot.gnu

[Comment]: Press "Enter" in terminal window in order to quit gnuplot
