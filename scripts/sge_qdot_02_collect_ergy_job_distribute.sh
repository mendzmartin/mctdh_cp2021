#!/bin/bash

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++		COMANDOS PARA CORRER EL PROCESO			++
# ++				DESDE BASH SHELL				++
# ++++++++++++++++++++++++++++++++++++++++++++++++++++                                 

# defines the bahaviour otherwise toggling
LANG=en_US

# PARAMETERS DECLARATIONS	
lambda_min=0.05
lambda_max=1
delta_lambda=0.05
COUNTER=1
# numero de configuración (cambiar!)
num_conf=01

# EXECUTION
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	# remove existing data
	rm -f result_energy_vs_lambda.dat

for i in $(seq $lambda_min $delta_lambda $lambda_max)
	rm -Rf double_qd_model_02_${COUNTER}/
	cd ../../../../scripts/

	do
		# change values outside according to looped variables
		sed '67,120 s/${i}/'${i}'/' sge_qdot_02_collect_ergy_job_run.sh >> intermediate_file_01_${COUNTER}.txt
		sed '67,120 s/${num_conf}/'${num_conf}'/' intermediate_file_01_${COUNTER}.txt >> intermediate_file_02_${COUNTER}.txt
		sed '67,120 s/${COUNTER}/'${COUNTER}'/' intermediate_file_02_${COUNTER}.txt >> sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		rm -f intermediate_file_01_${COUNTER}.txt intermediate_file_02_${COUNTER}.txt

		cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
		sed '2 s/${COUNTER}/'${COUNTER}'/' input_file.inp >> input_file_${COUNTER}.inp
		cd ../../../../scripts/		
		
		# remove unnecessary data, give permission and run script
		chmod +x sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		qsub ./sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		rm -f sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		
		cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
		rm -f input_file_${COUNTER}.inp

		COUNTER=$((COUNTER+1))
	done

mv result_energy_vs_lambda.dat configuration_${num_conf}/result_energy_vs_lambda.dat
cd ../../../../scripts/

# Notes:

# compilation:
# 	1) chmod +x script.sh
# 	2) ./script.sh
# performance
# 	1) perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
