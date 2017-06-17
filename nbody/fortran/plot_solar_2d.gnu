plot "tmp.trj" u 2:3 notitle w p pt 6 ps 1.0 lt 0
replot "all.trj" u 8:9 title "Mercury" w l lt 1
replot "tmp.trj" u 8:9 notitle w p pt 6 ps 1.0 lt 0 
replot "all.trj" u 14:15 title "Venus" w l lt 2
replot "tmp.trj" u 14:15 notitle pt 6 ps 1.0 lt 0
replot "all.trj" u 20:21 title "Earth" w l lt 3
replot "tmp.trj" u 20:21 notitle pt 6 ps 1.0 lt 0
replot "all.trj" u 32:33 title "Mars" w l lt 4
replot "tmp.trj" u 32:33 notitle pt 6 ps 1.0 lt 0
replot "all.trj" u 38:39 title "Jupiter" w l lt 5
replot "tmp.trj" u 38:39 notitle pt 6 ps 1.0 lt 0
