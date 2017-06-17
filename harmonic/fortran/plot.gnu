set size square

set xlabel "r - (x, y)"
set ylabel "v - (Vx, Vy)"

set xrange [-1.2:1.2]
set yrange [-1.2:1.2]

plot "plot.dat" u 2:4 w l title "(x, Vx)"
replot "plot.dat" u 3:5 w l title "(y, Vy)"
pause -1
