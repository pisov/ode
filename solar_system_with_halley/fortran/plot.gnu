set size square
set key outside
set xrange [-45:45]
set yrange [-45:45]
plot   "./evolution.trj" u ($2-$2):($3-$3) title "Sun" w l
replot "./evolution.trj" u ($8-$2):($9-$3) title "Mercury" w l
replot "./evolution.trj" u ($14-$2):($15-$3) title "Venus" w l
replot "./evolution.trj" u ($20-$2):($21-$3) title "Earth" w l
replot "./evolution.trj" u ($32-$2):($33-$3) title "Mars" w l
replot "./evolution.trj" u ($38-$2):($39-$3) title "Jupiter" w l
replot "./evolution.trj" u ($44-$2):($45-$3) title "Saturn" w l
replot "./evolution.trj" u ($50-$2):($51-$3) title "Uranus" w l
replot "./evolution.trj" u ($56-$2):($57-$3) title "Neptune" w l
replot "./evolution.trj" u ($62-$2):($63-$3) title "Pluto" w l
replot "./evolution.trj" u ($68-$2):($69-$3) title "Halley's commet" w l

pause -1

