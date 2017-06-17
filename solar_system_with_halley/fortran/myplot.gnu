#!/usr/bin/gnuplot 
set terminal postscript eps enhanced color "Helvetica" 50
set output "results.eps"

set style line 1 lt 1 lw 15 pt 5 ps 1 lc rgb "#d61818"
set style line 2 lt 2 lw 15 pt 9 ps 1 lc rgb "#072c76"
set style line 3 lt 3 lw 15 pt 9 ps 1 lc rgb "#072c76"
set style line 4 lt 4 lw 15 pt 7 ps 1 lc rgb "#208418"
set style line 5 lt 5 lw 15 pt 11 ps 1 lc rgb "#d97c19"

set size 6.0,3.0
set multiplot

set xlabel "x"
set ylabel "y"

set ytics 0.5

# plot A
set origin 0.0,0.0
set size 3.0,3.0

plot sin(x) ls 1

# plot B
set origin 3.0,0.0
set size 3.0,1.5

plot sin(x) ls 2
