#!/usr/bin/gnuplot
set terminal png size 1024,1024
set xlabel '{/Symbol l}' font 'Times Roman Bold Italic,20';set ylabel 'E [au]' font 'Times Roman Bold Italic,20'
set xrange[0.05:1]; set autoscale y
set title 'Collectioned energies for differents compile configurations' offset 0,-0.5 font 'Times Roman Bold Italic,20'
set label '-q long@compute-0-21.local,long@compute-0-22.local' at screen 0.25, 0.95 font 'Times Roman Bold Italic,16'
set key left top
set mxtics 20; set mytics 20;set grid mxtics mytics 
set output 'result_collectioned_energies.png'
plot 'configuration_01_v3/result_energy_vs_lambda.dat' u 1:2 smooth unique w lp lc rgb 'red' lw 3 ps 2 title 'conf_{01-v3}',\
    'configuration_02_v3/result_energy_vs_lambda.dat' u 1:2 smooth unique w lp lc rgb 'blue' lw 3 ps 2 title 'conf_{02-v3}',\
    'configuration_03_v3/result_energy_vs_lambda.dat' u 1:2 smooth unique w lp lc rgb 'green' lw 3 ps 2 title 'conf_{03-v3}',\
    'configuration_04_v3/result_energy_vs_lambda.dat' u 1:2 smooth unique w lp lc rgb 'orange' lw 3 ps 2 title 'conf_{04-v3}'
reset