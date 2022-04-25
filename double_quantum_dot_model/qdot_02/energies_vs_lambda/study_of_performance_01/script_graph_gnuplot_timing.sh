#!/usr/bin/gnuplot
set terminal png size 1024,1024
set xlabel '{/Symbol l}' font 'Times Roman Bold Italic,20'
set ylabel 't [s]' font 'Times Roman Bold Italic,20'
set xrange [0.05:1]; set autoscale y
set title 'Collection total elapsed time for differents compile configurations' offset 0,-0.5 font 'Times Roman Bold Italic,20'
xval=0.25;yval=0.95
set label '-q long@compute-0-21.local,long@compute-0-22.local' at screen xval, yval font 'Times Roman Bold Italic,16'
set key left top
set mxtics 20; set mytics 20;set grid mxtics mytics 
set output 'result_collection_total_timing_data.png'
plot	'result_collection_total_timing_data.dat' u 2:3 every ::1::20 title 'conf_{01}' smooth unique w lp lc rgb 'red' lw 3 ps 2,\
		'result_collection_total_timing_data.dat' u 2:3 every ::21::40 title 'conf_{02}' smooth unique w lp lc rgb 'blue' lw 3 ps 2,\
		'result_collection_total_timing_data.dat' u 2:3 every ::41::60 title 'conf_{03}' smooth unique w lp lc rgb 'green' lw 3 ps 2,\
		'result_collection_total_timing_data.dat' u 2:3 every ::61::80 title 'conf_{04}' smooth unique w lp lc rgb 'orange' lw 3 ps 2
reset