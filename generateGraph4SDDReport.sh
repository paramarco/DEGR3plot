#! /bin/bash
##################################################################
##
##   Script to generate all files used to generate SSD Report
##
##	Usage: ./generateGraph4SDDReport.sh 2014-05-19-06:10:00 2014-05-22-16:00:00 output.png
##
##
###################################################################


grep "UDP input stream (Mbps)" *.log > fileOnlyMbps.txt
cat fileOnlyMbps.txt | awk -f Mbps.awk > DECR_Mbps.dat

grep "Number of HCOR packets lost" *.log > HCORErrors.txt
cat HCORErrors.txt | awk -f HCORErrors.awk > HCORErrors.dat

grep "G3 CADUs lost" *.log > CADUsLost.txt
cat CADUsLost.txt  | awk -f CADUsLost.awk > CADUsLost.dat


cat <<EOC | sed "s/t1t1t1/$1/" | sed "s/t2t2t2/$2/" | sed "s/output.png/$3/" |gnuplot
set notitle
 
set timefmt "%Y-%m-%d-%H:%M:%S"

set xdata time
set xrange ["t1t1t1":"t2t2t2"]
#set format x "%m/%d %H"
set format x "%H:%M" 
#set xtics 10000 font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,6"
set xtics 100 font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,6" 
set xlabel "time"
 
set yrange [0:30]
set ytics 1 font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,6"
 
#set y2range [0:30000000]
set y2range [0:30000]
#set y2tics 1000000 font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,6"
set y2tics 1000 font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,6"
 
set ylabel "Realtime Mbps received" font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,14"
set y2label "HCOR/CADU Packets lost" font "/usr/share/fonts/dejavu/DejaVuSerif-Bold.ttf,14"

set grid xtics noytics
 
#unset title
 
set terminal png size 1600,800
set output "output.png"
 
plot 'DECR_Mbps.dat' using 1:2 with dots title 'Rate in Mbps' lt rgb "green" axis x1y1, \
     'CADUsLost.dat' using 1:2 with points title 'CADU lost' lt rgb "red" axis x1y2, \
     'HCORErrors.dat' using 1:2 with points title 'HCOR lost' lt rgb "blue" axis x1y2
EOC
