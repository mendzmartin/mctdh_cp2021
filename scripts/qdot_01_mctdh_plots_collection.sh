#!/bin/bash

# script de prueba para un solo valor de V_L = 0.4

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			parameters declaration			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

#index_min=0.4
#index_max=1.1
#delta_index=0.1

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				START SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

	# REMOVE EXISTING DIRECTORIES
	rm -Rf results-V_L-0.4
	rm -Rf plots_reduced_density
	# -------------------------------------------------------------------
	
	# START EXECUTION
	mctdh85 -D results-V_L-0.4 -w -mnd -p V_L 0.4 input_file_01.inp
	
	mkdir plots_reduced_density
	
	# START PLOTS COLLECTION
	# -------------------------------------------------------------------
	cd results-V_L-0.4
	
	rm -f tmpplot.pl
	
	showsys85 -rst <<- EOF
20
x=1, y=0
1
quit
EOF
	
	# GRAFICAR EN GNUPLOT
	# Crear un file nuevo pero cambiandoles ciertas filas para poder graficar
	# 	en gnuplot y que exporte gráfico como imágen.
	sed 's/set output/set terminal png size 1024,1024/g' tmpplot.pl > tmpplot_01.pl
	sed 's/set terminal x11/set output "graph.png"/g' tmpplot_01.pl > tmpplot_02.pl

	gnuplot tmpplot_02.pl
	echo -ne '\n' | echo
	
	mv graph.png ../plots_reduced_density/graph-V_L-0.4.png
	# -------------------------------------------------------------------
	
	cd ..
	rm -Rf results-V_L-0.4

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				END SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++
