#!/bin/bash
                            
# defines the bahaviour otherwise toggling
LANG=en_US

# PARAMETERS DECLARATIONS	
lambda_min=0.05
lambda_max=0.1
delta_lambda=0.05
COUNTER=1
num_conf=01 # numero de configuración (cambiar!)

# EXECUTION
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	# remove existing data
	rm -f result_energy_vs_lambda.dat

cd ../../../../scripts/
for i in $(seq $lambda_min $delta_lambda $lambda_max)
	do
		# change values outside according to looped variables
		sed '67,120 s/${i}/'${i}'/g' sge_qdot_02_collect_ergy_job_run.sh > intermediate_file_01_${COUNTER}.txt
		sed '67,120 s/${num_conf}/g'${num_conf}'/' intermediate_file_01_${COUNTER}.txt > intermediate_file_02_${COUNTER}.txt
		sed '67,120 s/${COUNTER}/g'${COUNTER}'/' intermediate_file_02_${COUNTER}.txt > sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		rm -f intermediate_file_01_${COUNTER}.txt intermediate_file_02_${COUNTER}.txt
		cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
		sed '2 s/${COUNTER}/g'${COUNTER}'/' input_file.inp > input_file_${COUNTER}.inp
		cd ../../../../scripts/
		
		# remove unnecessary data, give permission and run script
		chmod +x sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		qsub ./sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh 
		rm -f sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		COUNTER=$((COUNTER+1))
	done

	cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	rm -f input_file_${COUNTER}.inp
	mv result_energy_vs_lambda.dat configuration_${num_conf}/result_energy_vs_lambda.dat
	cd ../../../../scripts/

# Notes:
# perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
