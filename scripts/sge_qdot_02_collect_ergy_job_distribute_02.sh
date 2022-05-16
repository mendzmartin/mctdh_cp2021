#!/bin/bash
LANG=en_US # defines the bahaviour otherwise toggling
# PARAMETERS DECLARATIONS	
cores_min=1
cores_max=4
delta_cores=1
# EXECUTION
for i in $(seq $cores_min $delta_cores $cores_max)
	do
		for j in $(seq 1 1 20)
		do
			t_start=$(date +%s.%N) # medimos el tiempo al inicio
			# change values outside according to looped variables
			sed 's/${i}/'${i}'/g' sge_qdot_02_collect_ergy_job_run_02.sh > file_01_${i}.sh
			chmod +x file_01_${i}.sh	# give permission
			qsub ./file_01_${i}.sh  	# run script
			rm -f file_01_${i}.sh		# remove unnecessary data
			t_end=$(date +%s.%N) # medimos el tiempo al final
			t_elapsed=$(echo "${t_end} - ${t_start}" | bc)
			result="${j} ${t_elapsed}"
			cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_02/configuration_0${i}_v1/
				echo ${result} >> result_elapsed_time.dat
			cd ../../../../../scripts/
		done
	done
# Notes:
# perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
