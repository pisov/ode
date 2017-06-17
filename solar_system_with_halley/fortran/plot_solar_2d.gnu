plot   "tmp.trj" u ($2-$2):($3-$3)   notitle w p pt 6 ps 1.0 lt 0
replot "all.trj" u ($8-$2):($9-$3)   title "Mercury" w l lt 1
replot "tmp.trj" u ($8-$2):($9-$3)   notitle w p pt 6 ps 1.0 lt 0 
replot "all.trj" u ($14-$2):($15-$3) title "Venus" w l lt 2
replot "tmp.trj" u ($14-$2):($15-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($20-$2):($21-$3) title "Earth" w l lt 3
replot "tmp.trj" u ($20-$2):($21-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($32-$2):($33-$3) title "Mars" w l lt 4
replot "tmp.trj" u ($32-$2):($33-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($38-$2):($39-$3) title "Jupiter" w l lt 5
replot "tmp.trj" u ($38-$2):($39-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($44-$2):($45-$3) title "Saturn" w l lt 6
replot "tmp.trj" u ($44-$2):($45-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($50-$2):($51-$3) title "Uranus" w l lt 7
replot "tmp.trj" u ($50-$2):($51-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($56-$2):($57-$3) title "Neptune" w l lt 8
replot "tmp.trj" u ($56-$2):($57-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($62-$2):($63-$3) title "Pluto" w l lt 9
replot "tmp.trj" u ($62-$2):($63-$3) notitle pt 6 ps 1.0 lt 0
replot "all.trj" u ($68-$2):($69-$3) title "Halley's commet" w l lt 10 
replot "tmp.trj" u ($68-$2):($69-$3) notitle pt 6 ps 1.0 lt 0
