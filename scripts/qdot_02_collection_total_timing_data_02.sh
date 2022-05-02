#!/bin/bash
# PARAMETERS DECLARATION
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_02
rm -f result_collection_total_timing_data_v1.dat
for j in {1..4};
do
	cd configuration_0${j}_v1/double_qd_model_02_${j}_v1
	# START EXECUTION
	array_data=($(cat speed | tail -n 1))
	RealT="${array_data[6]}"
	result="${j} ${RealT}"
	# WRITE DATA
	cd ../../
	echo $result >> ./result_collection_total_timing_data_v1.dat
done
for j in {1..5};
do
	version=v${j}
	cd configuration_04_${version}/double_qd_model_02_4_${version}
	# START EXECUTION
	array_data=($(cat speed | tail -n 1))
	RealT="${array_data[6]}"
	result="v${j} ${RealT}"
	# WRITE DATA
	cd ../../
	echo $result >> ./result_collection_total_timing_data_v12345.dat
done

# compilation:
# 	1) chmod +x script.sh
#	2) ./script.sh
