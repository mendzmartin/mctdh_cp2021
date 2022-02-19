#!/bin/bash

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			parameters declaration			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

index_min=0.4
index_max=1.1
delta_index=0.1

# mostrar la ruta del directorio actual
#PWD=$(pwd)
#echo $PWD

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				START SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

rm -f energy-vs-V_L.dat

for i in $(seq $index_min $delta_index $index_max)
	do

		# REMOVE EXISTING DIRECTORIES
		rm -Rf results-V_L-$i
		
		# START EXECUTION
		mctdh85 -D results-V_L-$i -w -mnd -p V_L $i input_file_01.inp

		# START COLLECTION OF ENERGIES
		# -------------------------------------------------------------------
		cd results-V_L-$i
		
		# crear un array de elementos que hay dentro de un archivo
		energy=($(awk 'NR==5,NR==24 {print $3}' veigen_X1))
		
		cd ..
		
		# escribir todos los elementos del array
		# también funcionaría ${array[@]:s:n} que escribe n elementos contando desde el elemento s
		#guardar datos en document.dat
		
		echo ${i} ${energy[@]} >> energy-vs-V_L.dat
		# -------------------------------------------------------------------
		
		# REMOVE EXISTING DIRECTORIES
		rm -Rf results-V_L-$i
done

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				END SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

# Notes:

# take from XX-row to YY-row from XXXXX file and save data in XXXXX.dat
# -F, tells awk to use , as the field separator on input. This is equivalent to but much briefer than BEGIN {FS = ","}.
# NR := Number of Record
# print $3 tells awk to print the third column.
