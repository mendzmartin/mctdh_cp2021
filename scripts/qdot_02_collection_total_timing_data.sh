#!/bin/bash
# PARAMETERS DECLARATION
lambda_min=0.05
lambda_max=1
delta_lambda=0.05
version=v3 			# numero de version (cambiar!)
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_01
rm -f result_collection_total_timing_data_${version}.dat
for j in {1..4};
do
	cd configuration_0${j}_${version}
	rm -f result_collection_total_timing_data_${version}.da
	for i in {1..20};
	do
		cd double_qd_model_02_${i}
		k=$(expr ${i} - 1)
		lambda=$(echo "scale=2; ${lambda_min} + ${delta_lambda} * ${k}" | bc)
		# START EXECUTION
		array_data=($(cat speed | tail -n 1))
		RealT="${array_data[6]}"
		result="${j} ${lambda} ${RealT}"
		# WRITE DATA
		cd ../
		echo $result >> ../result_collection_total_timing_data_${version}.dat
	done
	cd ..
done

# compilation:
# 	1) chmod +x script.sh
#	2) ./script.sh
