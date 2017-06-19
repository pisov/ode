set xlabel "x"
set ylabel "Psi(x)"
plot "wfs.dat" u 1:2 w l title "Left"
replot "wfs.dat" u 3:4 w l title "Right"
pause -1
