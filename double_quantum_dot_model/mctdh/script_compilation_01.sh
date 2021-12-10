#!/bin/bash

# +++ Declaración de parámetros
#index_min=0.4
#index_max=1.1
#delta_index=0.1

# +++ Imprimo mensaje
echo #
echo ++++++++++++++++++ START ++++++++++++++++++
echo #
# +++ Bucle for para crear un directorio diferente para cada valor del parámetro V_L
## The C-style Bash for loop ##
#for i in seq -f "%f" $index_min $delta_index $index_max
for i in 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1
	do mctdh85 -D results-V_L-$i -w -mnd -p V_L $i input_file_01.inp
done
