#!/bin/bash

# defines the bahaviour otherwise toggling
LANG=en_US

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			PARAMETERS DECLARATION			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

lambda_min=0.05
lambda_max=1
delta_lambda=0.05

COUNTER=1

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/

# REMOVE EXISTING DATA
rm -f result_energy_vs_lambda.dat
rm -Rf double_qd_model_02/

for i in $(seq $lambda_min $delta_lambda $lambda_max)
	do
	
	# START EXECUTION
	mctdh85 -mnd -p V_L 0.9,au -p lambda $i input_file.inp


	# START COLLECTION OF ENERGIES
	cd double_qd_model_02/
	array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
	energy_part1="${array_energy[4]}"
	energy_part2="${array_energy[5]}"
	result="$i ${energy_part1}${energy_part2}"
	
	# WRITE DATA
	cd ..
	echo $result >> result_energy_vs_lambda.dat
	
	# SAVE DATA FOLDER
	mv double_qd_model_02/ configuration_01/double_qd_model_02_$COUNTER/
	
	COUNTER=$((COUNTER+1))
done

mv result_energy_vs_lambda.dat configuration_01/result_energy_vs_lambda.dat

# Notes:

# compilation:
# 	1) chmod +x script.sh
# 	2) ./script.sh
# performance
# 	1) perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
