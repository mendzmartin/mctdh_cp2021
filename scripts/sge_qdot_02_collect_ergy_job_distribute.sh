#!/bin/bash

# defines the bahaviour otherwise toggling
LANG=en_US

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			PARAMETERS DECLARATION			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++

lambda_min=0.5
lambda_max=1
delta_lambda=0.5

COUNTER=1

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	# REMOVE EXISTING DATA
	rm -f result_energy_vs_lambda.dat
	rm -Rf double_qd_model_02/

cd ../../../../scripts/
	for i in $(seq $lambda_min $delta_lambda $lambda_max)
		do
		# change values accordingto for loop and COUNTER
		sed '91 s/${i}/'${i}'/' sge_qdot_02_collect_ergy_job_run.sh >> intermediate_file_01.txt
		sed '98 s/${i}/'${i}'/' intermediate_file_01.txt >> intermediate_file_02.txt
		sed '105 s/${COUNTER}/'${COUNTER}'/' intermediate_file_02.txt sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		
		# remove unnecessary data, give permission and run script
		rm -f intermediate_file_01.txt intermediate_file_02.txt
		chmod +x sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		./sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		rm -f sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		
		COUNTER=$((COUNTER+1))
	done

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	mv result_energy_vs_lambda.dat configuration_01/result_energy_vs_lambda.dat

# Notes:

# compilation:
# 	1) chmod +x script.sh
# 	2) ./script.sh
# performance
# 	1) perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
