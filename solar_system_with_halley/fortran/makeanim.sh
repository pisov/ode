#!/bin/bash

LENGTH=1.0
NUMREC=3650
FILE=evolution.trj
TRJFILE=tmp.trj
TRJFALL=all.trj
ANIMFILE=anim.gnu
BASEANIM=plot_solar_2d.gnu
STEP=1.0
NUMSTEPS=`echo "scale = 0; $NUMREC / $STEP" | bc -l`
NUMLINES=`echo "scale = 0; $LENGTH / $STEP" | bc -l`
XANGLE=60

rm -rf frame*.png

for INDX in `seq 1 $NUMREC`
do
  TRJSTEPS=`echo "scale = 0; $INDX / $STEP" | bc -l`
  head -$TRJSTEPS $FILE | tail -$NUMLINES > $TRJFILE
  head -$TRJSTEPS $FILE > $TRJFALL
  ZANGLE=`echo "scale = 0; ($INDX - 1) * 90 / ($NUMREC - 1) + 30" | bc -l`
#  XANGLE=`echo "scale = 0; 60 - ($INDX - 1) * 15 / ($NUMREC - 1)" | bc -l`
  printf 'set size square\n' > $ANIMFILE
  printf 'set key outside\n' >> $ANIMFILE
  printf 'set xrange [-45:45]\n' >> $ANIMFILE
  printf 'set yrange [-45:45]\n' >> $ANIMFILE
#  printf 'set zrange [-0.0005:0.0005]\n' >> $ANIMFILE
#  printf 'set view %s, %s\n' $XANGLE $ZANGLE >> $ANIMFILE
  printf 'set output \"frame%05d.png\"\n' $INDX >> $ANIMFILE
  printf 'set term png size 720,720\n' >> $ANIMFILE
  cat $BASEANIM >> $ANIMFILE
  printf 'set output\n' $INDX >> $ANIMFILE
  printf 'set output \"frame%05d.png\"\n' $INDX >> $ANIMFILE
  printf 'replot\n' $INDX >> $ANIMFILE
  printf 'set output\n' $INDX >> $ANIMFILE
  gnuplot $ANIMFILE
done 

rm -f $TRJFILE $TRJFALL $ANIMFILE anim.gif

convert frame*.png anim.gif
/opt/physon/bin/ffmpeg -r 60 -f image2 -s 720x720 -i frame%05d.png -vcodec libx264 -crf 25  -pix_fmt yuv420p solar.mp4

#rm -rf frame*.png
