
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

set key at screen 3.7,3.35

