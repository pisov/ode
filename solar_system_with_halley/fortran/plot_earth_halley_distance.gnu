set ylabel "Distance between Earth and Halley's commet [au]"
set xlabel "Time [years]"
plot "./evolution.trj" u ($1/365):(sqrt(($20-$68)**2+($21-$69)**2)) w l notitle
pause -1
