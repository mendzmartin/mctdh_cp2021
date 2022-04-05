#!/usr/bin/gnuplot

######################################################
# GRAFICAR SOLUCION (POSICIÓN)
######################################################
	# kind of output to generate
	set terminal png size 1024,1024
	show terminal
	# redirect the output toa file or device
	set output 'result_collection_total_timing_data.png'

	# generate de axis titles
	set xlabel 'lambda' font 'Times Roman Bold Italic,20'
	set ylabel 'total elapsed time [s]' font 'Times Roman Bold Italic,20'

	set xrange [0.05:1]
	set autoscale y

	# plots functions with linespoints
	#set style function linespoints

	# define linestyles
	set style line 1 linetype rgb "red" linewidth 3
	set style line 2 linetype rgb "green" linewidth 3
	set style line 3 linetype rgb "blue" linewidth 3
	set style line 4 linetype rgb "violet" linewidth 3
	set style line 5 linetype rgb "black" linewidth 3
	set style line 6 linetype rgb "sienna4" linewidth 3
	

	set title 'Collection total timing data for differents compile configurations' offset 0,-0.5 font 'Times Roman Bold Italic,20'
	XVAL=512
	YVAL=512
	set label "textbox" at screen XVAL, screen YVAL font 'Times Roman Bold Italic,20'

	# create plot
	plot	'result_collection_total_timing_data.dat' using 2:3 every ::1::20 title 'conf 01' smooth unique with linespoints linestyle 1,\
			'result_collection_total_timing_data.dat' using 2:3 every ::21::40 title 'conf 02' smooth unique with linespoints linestyle 2,\
			'result_collection_total_timing_data.dat' using 2:3 every ::41::60 title 'conf 03' smooth unique with linespoints linestyle 3,\
			'result_collection_total_timing_data.dat' using 2:3 every ::61::80 title 'conf 04' smooth unique with linespoints linestyle 4

	# reset all of graph characteristics to default values
	reset
