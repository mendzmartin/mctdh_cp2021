#!/bin/bash

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			PARAMETERS DECLARATION			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

index_min=0.4
index_max=1.1
delta_index=0.1

cd ../double_quantum_dot_model/qdot_02/convergence_analysis

# REMOVE EXISTING DATA
rm -f result_fundamental_energy_lambda_zero_07.dat

for i in $(seq $index_min $delta_index $index_max)
	do
	
	# REMOVE EXISTING DIRECTORIES
	rm -Rf double_qd_model_02
	
	# START EXECUTION
	mctdh85 -w -mnd -p V_L $i,au -p lambda 0 input_file_02_convergence_analysis_07.inp


	# START COLLECTION OF ENERGIES
	cd double_qd_model_02
	array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
	energy_part1="${array_energy[4]}"
	energy_part2="${array_energy[5]}"
	result="$i ${energy_part1}${energy_part2}"
	
	# REMOVE EXISTING DIRECTORIES
	rm -Rf double_qd_model_02
	
	# WRITE DATA
	cd ..
	echo $result >> result_fundamental_energy_lambda_zero_07.dat

done
