#!/bin/bash

LENGTH=0.01
NUMREC=356
FILE=evolution.trj
TRJFILE=tmp.trj
TRJFALL=all.trj
ANIMFILE=anim.gnu
BASEANIM=plot_solar_3d.gnu
STEP=0.01
NUMSTEPS=`echo "scale = 0; $NUMREC / $STEP" | bc -l`
NUMLINES=`echo "scale = 0; $LENGTH / $STEP" | bc -l`
XANGLE=60

for INDX in `seq 1 $NUMREC`
do
  TRJSTEPS=`echo "scale = 0; $INDX / $STEP" | bc -l`
  head -$TRJSTEPS $FILE | tail -$NUMLINES > $TRJFILE
  head -$TRJSTEPS $FILE > $TRJFALL
  ZANGLE=`echo "scale = 0; ($INDX - 1) * 90 / ($NUMREC - 1) + 30" | bc -l`
  XANGLE=`echo "scale = 0; 90 - ($INDX - 1) * 90 / ($NUMREC - 1)" | bc -l`
  printf 'set size square\n' > $ANIMFILE
  printf 'set xrange [-5:2]\n' >> $ANIMFILE
  printf 'set yrange [-2:5]\n' >> $ANIMFILE
  printf 'set zrange [-0.05:0.05]\n' >> $ANIMFILE
  printf 'set view %s, %s\n' $XANGLE $ZANGLE >> $ANIMFILE
  printf 'set output \"frame%05d.png\"\n' $INDX >> $ANIMFILE
  printf 'set term png\n' >> $ANIMFILE
  cat $BASEANIM >> $ANIMFILE
  printf 'set output\n' $INDX >> $ANIMFILE
  printf 'set output \"frame%05d.png\"\n' $INDX >> $ANIMFILE
  printf 'replot\n' $INDX >> $ANIMFILE
  printf 'set output\n' $INDX >> $ANIMFILE
  gnuplot $ANIMFILE
done 

rm -f $TRJFILE $ANIMFILE solar_3d.gif

convert frame*.png solar_3d.gif

rm -rf frame*.png
