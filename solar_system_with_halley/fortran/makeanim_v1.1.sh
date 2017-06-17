#!/bin/bash

LENGTH=1.0
NUMREC=5
FILE=evolution.trj
TRJFILE=tmp.trj
TRJFALL=all.trj
ANIMFILE=anim.gnu
BASEANIM=template.gnu
STEP=1.0
NUMSTEPS=`echo "scale = 0; $NUMREC / $STEP" | bc -l`
NUMLINES=`echo "scale = 0; $LENGTH / $STEP" | bc -l`
XANGLE=60
BASEDATE="2017-03-23"

rm -rf frame*.png

for INDX in `seq 1 $NUMREC`
do
  echo -n "Processing step $INDX"
  TRJSTEPS=`echo "scale = 0; $INDX / $STEP" | bc -l`
#  head -$TRJSTEPS $FILE | tail -$NUMLINES > $TRJFILE
  sed -n -e $((TRJSTEPS-NUMLINES+1)),${TRJSTEPS}p -e $((TRJSTEPS+1))q $FILE > $TRJFILE
#  echo -n "sed -n -e $((TRJSTEPS-NUMLINES+1)),${TRJSTEPS}p -e $((TRJSTEPS+1))q $FILE > $TRJFILE"
#  head -$TRJSTEPS $FILE > $TRJFALL
  sed -n -e 1,${TRJSTEPS}p -e $((TRJSTEPS+1))q $FILE > $TRJFALL

  day=`tail -1 $TRJFALL | awk '{printf("%.f\n",$1)}'`
  DATE=`date +"%Y-%m-%d" -d "2017-03-23 + $day days"`
  ZANGLE=`echo "scale = 0; ($INDX - 1) * 90 / ($NUMREC - 1) + 30" | bc -l`
#  XANGLE=`echo "scale = 0; 60 - ($INDX - 1) * 15 / ($NUMREC - 1)" | bc -l`
  printf 'set title \"'$DATE'\"\n' > $ANIMFILE
  cat $BASEANIM >> $ANIMFILE
  gnuplot $ANIMFILE
  convert results.eps -resize x720 `printf 'frame%05d.png' $INDX`
done 

#rm -f $TRJFILE $TRJFALL $ANIMFILE anim.gif

#convert frame*.png anim.gif

#/opt/physon/bin/ffmpeg -r 60 -f image2 -s 720x720 -i frame%05d.png -vcodec libx264 -crf 25  -pix_fmt yuv420p solar.mp4
