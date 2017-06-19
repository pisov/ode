set size square
set xlabel "X"
set ylabel "WF"
plot "wf001.dat" u 1:2 w p pt 6 ps 0.2 title "Phi1 Left"
replot "wf001.dat" u 1:4 w p pt 6 ps 0.2 title "Phi1 Right"

pause 10

plot "wf002.dat" u 1:2 w p pt 6 ps 0.2 title "Phi2 Left"
replot "wf002.dat" u 1:4 w p pt 6 ps 0.2 title "Phi2 Right"

pause 10

plot "wf003.dat" u 1:2 w p pt 6 ps 0.2 title "Phi3 Left"
replot "wf003.dat" u 1:4 w p pt 6 ps 0.2 title "Phi3 Right"

pause 10

