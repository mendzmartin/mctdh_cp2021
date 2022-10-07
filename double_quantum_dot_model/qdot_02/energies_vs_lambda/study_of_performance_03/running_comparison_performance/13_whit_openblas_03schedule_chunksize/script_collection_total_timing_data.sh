#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

#LANG=en_US
pow_min=5
pow_max=10
delta_pow=1

rm -f result_collection_total_timing_data.dat
data_value="    chunksize    CPU-RealTime[s]    "
echo ${data_value} >> ./result_collection_total_timing_data.dat

for i in $(seq ${pow_min} ${delta_pow} ${pow_max})
	do
    chunksize=$((2**${i}))
	cd result_double_qd_model_02_chunksz${chunksize}
 	array_data=($(cat speed | tail -n 1))
	CPUtime="${array_data[6]}"
	data_value="    ${chunksize}    ${CPUtime}"
	cd ../
	echo ${data_value} >> ./result_collection_total_timing_data.dat
done

echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '++++               END-END-END-END-END                ++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

# commands: chmod +x script_collection_total_timing_data.sh
#           ./script_collection_total_timing_data.sh
#	    	./plot_result_collection_total_timing_data.dat