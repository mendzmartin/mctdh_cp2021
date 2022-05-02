#!/bin/bash
LANG=en_US			# defines the bahaviour otherwise toggling
# PARAMETERS DECLARATION
lambda_min=0.05		# valor mínimo
lambda_max=1		# valor maximo
delta_lambda=0.05	# paso
COUNTER=1			# contador
ext=03_v4 			# extención especifica del directorio (cambiar!)
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_01/configuration_${ext}
# REMOVE EXISTING DATA
rm -f result_energy_vs_lambda.dat
for i in $(seq $lambda_min $delta_lambda $lambda_max)
	do
	# START COLLECTION OF ENERGIES
	cd double_qd_model_02_${COUNTER}/

	# # descomentar para ext=0i_v2, i={1,2,3,4}
	# array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
	# energy_part1="${array_energy[4]}"
	# energy_part2="${array_energy[5]}"
	# result="${i} ${energy_part1}${energy_part2}"

	# comentar para ext=0i_v2, i={1,2,3,4}
	array_energy=($(rdrlx | tail -n 4 | sed -n '1 p'))
	energy_part1="${array_energy[5]}"
	result="${i} ${energy_part1}"

	# WRITE DATA
	cd ../
	echo ${result} >> result.dat
	sort -n -r result.dat >> result_energy_vs_lambda.dat # ordenar datos
	rm -f result.dat
	COUNTER=$((COUNTER+1))
done

# Notes:

# compilation:
# 	1) chmod +x script.sh
# 	2) ./script.sh
# performance
# 	1) perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
