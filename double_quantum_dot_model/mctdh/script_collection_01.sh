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

for i in $(seq $index_min $delta_index $index_max)
	do
		cd results-V_L-$i
		
		# crear un array de elementos que hay dentro de un archivo
		energy=($(awk 'NR==5,NR==24 {print $3}' veigen_X1))
		
		# escribir todos los elementos del array
		# también funcionaría ${array[@]:s:n} que escribe n elementos contando desde el elemento s
		echo ${i} ${energy[@]}
		
		cd ..
done

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				END SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++
