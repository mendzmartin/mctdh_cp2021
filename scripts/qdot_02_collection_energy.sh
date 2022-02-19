#!/bin/bash

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			PARAMETERS DECLARATION			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

lambda_min=0.01
lambda_max=0.1
delta_lambda=0.01

cd ../double_quantum_dot_model/qdot_02

# REMOVE EXISTING DATA
rm -f result_energy_vs_lambda.dat

for i in $(seq $lambda_min $delta_lambda $lambda_max)
	do
	
	# REMOVE EXISTING DIRECTORIES
	rm -Rf double_qd_model_02
	
	# START EXECUTION
	mctdh85 -w -mnd -p V_L 0.9,au -p lambda $i input_file_02.inp


	# START COLLECTION OF ENERGIES
	cd double_qd_model_02
	array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
	energy_part1="${array_energy[4]}"
	energy_part2="${array_energy[5]}"
	result="$i ${energy_part1}${energy_part2}"
	
	# WRITE DATA
	cd ..
	echo $result >> result_energy_vs_lambda.dat

	# REMOVE EXISTING DIRECTORIES
	rm -Rf double_qd_model_02
	
done

# Notes:

# compilation:
# 	1) chmod +x script.sh
#	2) ./script.sh
