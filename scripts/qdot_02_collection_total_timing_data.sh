#!/bin/bash

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			PARAMETERS DECLARATION			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++
lambda_min=0.05
lambda_max=1
delta_lambda=0.05

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance
rm -f result_collection_total_timing_data.dat


for j in {1..4};
do
	cd configuration_0${j}
	
	rm -f result_collection_total_timing_data.dat

	for i in {1..20};
	do
		cd double_qd_model_02_$i
		
		k=$(expr $i - 1)
		lambda=$(echo "scale=2; $lambda_min + $delta_lambda * $k" | bc)
		
		# START EXECUTION
		
		array_data=($(cat speed | tail -n 1))
		RealT="${array_data[6]}"
		result="$j $lambda ${RealT}"
		
		# WRITE DATA
		cd ../
		echo $result >> ../result_collection_total_timing_data.dat
	done
	
	cd ..
	
done

# Notes:

# compilation:
# 	1) chmod +x script.sh
#	2) ./script.sh
