#!/bin/bash
# BEGAVIOUR OTHERWISE TOGGLING
LANG=en_US
# PARAMETERS DECLARATION
lambda_min=0.00;lambda_max=1.00;delta_lambda=0.05
COUNTER=1
# REMOVE EXISTING DATA
rm -f result_energy_vs_lambda.dat result_cputime_vs_lambda.dat
for i in $(seq $lambda_min $delta_lambda $lambda_max)
	do
	# START COLLECTION OF ENERGIES
	cd result_double_qd_model_02_lambda${i}/

    if [ ${COUNTER} -eq 1 ];then
	    array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
	    energy_part1="${array_energy[4]}"
	    energy_part2="${array_energy[5]}"
	    result_energy="${i} ${energy_part1}${energy_part2}"
    else
        array_energy=($(rdrlx | tail -n 4 | sed -n '1 p'))
	    energy_part1="${array_energy[4]}"
	    energy_part2="${array_energy[5]}"
	    result_energy="${i} ${energy_part1}${energy_part2}"
    fi

    array_cpu_time=($(cat timing | tail -n 6| sed -n '1 p'))
	cpu_time="${array_cpu_time[4]}"
	result_cpu_time="${i} ${cpu_time}"

	# WRITE DATA
	cd ../
	echo ${result_energy} >> result_energy_vs_lambda.dat
    echo ${result_cpu_time} >> result_cputime_vs_lambda.dat

    COUNTER=$((COUNTER+1))
done

# Notes:

# compilation:
# 	1) chmod +x script.sh
# 	2) ./script.sh
# performance
# 	1) perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
