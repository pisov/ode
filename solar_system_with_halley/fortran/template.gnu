set terminal postscript eps enhanced color "Helvetica" 50 linewidth 4
set output "results.eps"


set style line 1  lt 1 lw 3.5 pt 1  ps 1 lc rgb "#CB1E00"
set style line 2  lt 1 lw 3.5 pt 2  ps 1 lc rgb "#2300E5"
set style line 3  lt 1 lw 3.5 pt 3  ps 1 lc rgb "#24C700"
set style line 4  lt 1 lw 3.5 pt 4  ps 1 lc rgb "#070033"
set style line 5  lt 1 lw 3.5 pt 5  ps 1 lc rgb "#0071DC"
set style line 6  lt 1 lw 3.5 pt 6  ps 1 lc rgb "#A2BF00"
set style line 7  lt 1 lw 3.5 pt 7  ps 1 lc rgb "#D800B7"
set style line 8  lt 1 lw 3.5 pt 8  ps 1 lc rgb "#64C300"
set style line 9  lt 1 lw 3.5 pt 9  ps 1 lc rgb "#D6EA06"
set style line 10 lt 1 lw 3.5 pt 10 ps 1 lc rgb "#6D00E0"


set size 6.4,3.6
set multiplot

set size ratio 1
set origin 0,0
set size 3.6,3.6


set xrange [-45:45]
set yrange [-45:45]
unset xlabel
unset ylabel

set key at screen 4,3.0

plot   "tmp.trj" u ($2-$2):($3-$3)   notitle w p pt 6 ps 2.0 lt 0
replot "all.trj" u ($8-$2):($9-$3)   title "Mercury" w l ls 1 
replot "tmp.trj" u ($8-$2):($9-$3)   notitle w p pt 6 ps 3.0 lt 0
replot "all.trj" u ($14-$2):($15-$3) title "Venus" w l ls 2
replot "tmp.trj" u ($14-$2):($15-$3) notitle pt 6 ps 3.0 lt 0 
replot "all.trj" u ($20-$2):($21-$3) title "Earth" w l ls 3
replot "tmp.trj" u ($20-$2):($21-$3) notitle pt 6 ps 3.0 lt 0
replot "all.trj" u ($32-$2):($33-$3) title "Mars" w l ls 4
replot "tmp.trj" u ($32-$2):($33-$3) notitle pt 6 ps 3.0 lt 0
replot "all.trj" u ($38-$2):($39-$3) title "Jupiter" w l ls 5
replot "tmp.trj" u ($38-$2):($39-$3) notitle pt 6 ps 4.0 lt 0
replot "all.trj" u ($44-$2):($45-$3) title "Saturn" w l ls 6
replot "tmp.trj" u ($44-$2):($45-$3) notitle pt 6 ps 4.0 lt 0
replot "all.trj" u ($50-$2):($51-$3) title "Uranus" w l ls 7
replot "tmp.trj" u ($50-$2):($51-$3) notitle pt 6 ps 4.0 lt 0
replot "all.trj" u ($56-$2):($57-$3) title "Neptune" w l ls 8
replot "tmp.trj" u ($56-$2):($57-$3) notitle pt 6 ps 4.0 lt 0
replot "all.trj" u ($62-$2):($63-$3) title "Pluto" w l ls 9
replot "tmp.trj" u ($62-$2):($63-$3) notitle pt 6 ps 4.0 lt 0
replot "all.trj" u ($68-$2):($69-$3) title "Halley's commet" w l ls 10
replot "tmp.trj" u ($68-$2):($69-$3) notitle pt 6 ps 3.0 lt 0

unset title

set size ratio 0.4
set origin 3.2,0
set size 2.8,1.3

unset xtics
set x2tics mirror
set x2range [0:100]
set yrange  [0:35]
set x2label "Time [Years]"
set ylabel "Distance Earth-H Commet [au]"

plot "all.trj" u ($1/365):(sqrt(($20-$68)**2+($21-$69)**2)) w l notitle ls 1 axes x2y1
plot "tmp.trj" u ($1/365):(sqrt(($20-$68)**2+($21-$69)**2)) notitle w p pt 6 ps 3.0 lt 0 axes x2y1

set size ratio 0.4
set origin 3.2,1.3
set size 2.8,1.3

unset xtics
set x2tics mirror
set x2range [0:100]
set yrange  [0:5]
set x2label "Time [Years]"
set ylabel "Distance Mars-Earth [au]"

plot "all.trj" u ($1/365):(sqrt(($20-$32)**2+($21-$33)**2)) w l notitle ls 1 axes x2y1
plot "tmp.trj" u ($1/365):(sqrt(($20-$32)**2+($21-$33)**2)) notitle w p pt 6 ps 3.0 lt 0 axes x2y1


unset multiplot
set size 6.4,3.6