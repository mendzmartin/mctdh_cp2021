#!/bin/bash

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			parameters declaration			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

index_min=0.4
index_max=1.1
delta_index=0.1

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				START SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

for i in $(seq $index_min $delta_index $index_max)
	do mctdh85 -D results-V_L-$i -w -mnd -p V_L $i input_file_01.inp
done

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++				END SCRIPT				+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++
