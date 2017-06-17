#!/bin/bash

LENGTH=1.0
NUMREC=3650
FILE=evolution.trj
ANIMFILE=anim.gnu
BASEANIM=template.gnu
STEP=1.0
BASEDATE="2017-03-23"

rm -rf frame*.png

for INDX in `seq 1 $NUMREC`
do
  echo -n "Processing step $INDX"

  DATE=`date +"%Y-%m-%d" -d "2017-03-23 + $day days"`

  cat head_1_template.gnu > $ANIMFILE

  printf 'set title \"'$DATE'\"\n' >> $ANIMFILE
  printf 'plot   \"evolution.trj\" every ::%d::%d u ($2-$2):($3-$3)   notitle w p pt 6 ps 2.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($8-$2):($9-$3)   title \"Mercury\" w l ls 1\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($8-$2):($9-$3)   notitle w p pt 6 ps 3.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($14-$2):($15-$3) title \"Venus\" w l ls 2\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($14-$2):($15-$3) notitle pt 6 ps 3.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($20-$2):($21-$3) title \"Earth\" w l ls 3\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($20-$2):($21-$3) notitle pt 6 ps 3.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($32-$2):($33-$3) title \"Mars\" w l ls 4\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($32-$2):($33-$3) notitle pt 6 ps 3.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($38-$2):($39-$3) title \"Jupiter\" w l ls 5\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($38-$2):($39-$3) notitle pt 6 ps 4.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($44-$2):($45-$3) title \"Saturn\" w l ls 6\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($44-$2):($45-$3) notitle pt 6 ps 4.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($50-$2):($51-$3) title \"Uranus\" w l ls 7\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($50-$2):($51-$3) notitle pt 6 ps 4.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($56-$2):($57-$3) title \"Neptune\" w l ls 8\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($56-$2):($57-$3) notitle pt 6 ps 4.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($62-$2):($63-$3) title \"Pluto\" w l ls 9\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($62-$2):($63-$3) notitle pt 6 ps 4.0 lt 0\n' $INDX $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($68-$2):($69-$3) title \"Halley commet\" w l ls 10\n' 1 $INDX >>  $ANIMFILE
  printf 'replot \"evolution.trj\" every ::%d::%d u ($68-$2):($69-$3) notitle pt 6 ps 3.0 lt 0\n' $INDX $INDX >>  $ANIMFILE

  cat head_2_template.gnu >> $ANIMFILE

  printf 'plot \"evolution.trj\" every ::%d::%d u ($1/365):(sqrt(($20-$68)**2+($21-$69)**2)) w l notitle ls 1 axes x2y1\n' 1 $INDX >>  $ANIMFILE
  printf 'plot \"evolution.trj\" every ::%d::%d u ($1/365):(sqrt(($20-$68)**2+($21-$69)**2)) notitle w p pt 6 ps 3.0 lt 0 axes x2y1\n' $INDX $INDX >>  $ANIMFILE

  cat head_3_template.gnu >> $ANIMFILE

  printf 'plot \"evolution.trj\" every ::%d::%d u ($1/365):(sqrt(($20-$32)**2+($21-$33)**2)) w l notitle ls 1 axes x2y1\n' 1 $INDX >>  $ANIMFILE
  printf 'plot \"evolution.trj\" every ::%d::%d u ($1/365):(sqrt(($20-$32)**2+($21-$33)**2)) notitle w p pt 6 ps 3.0 lt 0 axes x2y1\n' $INDX $INDX >>  $ANIMFILE
  
  printf 'unset multiplot\n' >>  $ANIMFILE
  printf 'set size 6.4,3.6\n' >>  $ANIMFILE

  gnuplot $ANIMFILE
  convert results.eps -resize 1920x1080 -background "#FFFFFF" -flatten `printf 'frame%05d.png' $INDX`
#  convert tmp.png -gravity center -crop 1280x720+0+0 `printf 'frame%05d.png' $INDX`
done 

#rm -f $TRJFILE $TRJFALL $ANIMFILE anim.gif

#convert frame*.png anim.gif

#/opt/physon/bin/ffmpeg -r 60 -f image2 -s 720x720 -i frame%05d.png -vcodec libx264 -crf 25  -pix_fmt yuv420p solar.mp4
