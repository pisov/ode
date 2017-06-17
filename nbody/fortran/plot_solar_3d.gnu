set view equal xy
unset border
unset xtics
unset ytics
unset ztics
splot "tmp.trj" u 2:3:4 notitle w p pt 6 ps 1.0 lt 0
replot "all.trj" u 8:9:10 title "Mercury" w l lt 1
replot "tmp.trj" u 8:9:10 notitle w p pt 6 ps 1.0 lt 0 
replot "all.trj" u 14:15:16 title "Venus" w l lt 2
replot "tmp.trj" u 14:15:16 notitle pt 6 ps 1.0 lt 0
replot "all.trj" u 20:21:22 title "Earth" w l lt 3
replot "tmp.trj" u 20:21:22 notitle pt 6 ps 1.0 lt 0
replot "all.trj" u 32:33:34 title "Mars" w l lt 4
replot "tmp.trj" u 32:33:34 notitle pt 6 ps 1.0 lt 0
replot "all.trj" u 38:39:40 title "Jupiter" w l lt 5
replot "tmp.trj" u 38:39:40 notitle pt 6 ps 1.0 lt 0
