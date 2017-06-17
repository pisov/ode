set size square
plot   "./evolution.trj" u 5:6 title "Sun" w l
replot "./evolution.trj" u 8:9 title "Mercury" w l
replot "./evolution.trj" u 14:15 title "Venus" w l
replot "./evolution.trj" u 20:21 title "Earth" w l
replot "./evolution.trj" u 32:33 title "Mars" w l
replot "./evolution.trj" u 38:39 title "Jupiter" w l

pause -1

