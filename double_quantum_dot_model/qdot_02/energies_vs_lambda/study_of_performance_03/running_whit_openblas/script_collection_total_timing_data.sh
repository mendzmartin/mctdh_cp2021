#!/bin/bash

LANG=en_US			# defines the bahaviour otherwise toggling

# PARAMETERS DECLARATION
lambda_min=0.00		# valor mínimo
lambda_max=1.00		# valor maximo
delta_lambda=0.05	# paso

rm -f result_collection_total_timing_data.dat
data_value="#     lambda     CPU-RealTime[s]"
echo ${data_value} >> ./result_collection_total_timing_data.dat

for i in $(seq ${lambda_min} ${delta_lambda} ${lambda_max})
	do
    cd result_double_qd_model_02_lambda${i}

    # COLLECT TIME
    array_data=($(cat speed | tail -n 1))
	CPUtime="${array_data[6]}"
	data_value="     ${i}     ${CPUtime}"

   # WRITE DATA
	cd ../
	echo ${data_value} >> ./result_collection_total_timing_data.dat
done

# commands: chmod +x script_collection_total_timing_data.sh
#           ./script_collection_total_timing_data.sh
#	    	./plot_result_collection_total_timing_data.dat