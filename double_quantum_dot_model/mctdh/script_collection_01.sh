#!/bin/bash

# +++ Declaración de parámetros
index_min=0.4
index_max=1.1
delta_index=0.1
PWD=$(pwd)
#echo $PWD
# +++ Imprimo mensaje
#echo #
#echo ++++++++++++++++++ START ++++++++++++++++++
#echo #
# +++ Bucle for para crear un directorio diferente para cada valor del parámetro V_L
## The C-style Bash for loop ##
#for i in seq -f "%f" $index_min $delta_index $index_max
for i in $(seq $index_min $delta_index $index_max);do
  #echo $i
  cd results-V_L-$i
  #for q in 1..2
    energ=($(awk 'NR==5,NR==25 {print $3}' veigen_X1))
  #done
  echo ${i} ${energ[@]}
  cd ..
done
