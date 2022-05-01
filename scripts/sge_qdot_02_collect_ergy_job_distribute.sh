#!/bin/bash                          
LANG=en_US # defines the bahaviour otherwise toggling
# PARAMETERS DECLARATIONS	
lambda_min=0.05
lambda_max=1
delta_lambda=0.05
COUNTER=1
num_conf=03 		# numero de configuración (cambiar!)
# EXECUTION
for i in $(seq $lambda_min $delta_lambda $lambda_max)
	do
		# change values outside according to looped variables
		sed 's/${i}/'${i}'/g' sge_qdot_02_collect_ergy_job_run.sh > file01_${COUNTER}.dat
		sed 's/${num_conf}/'${num_conf}'/g' file01_${COUNTER}.dat > file02_${COUNTER}.dat
		sed 's/${COUNTER}/'${COUNTER}'/g' file02_${COUNTER}.dat > file03_${COUNTER}.sh
		# remove unnecessary data, give permission and run script
		rm -f file01_${COUNTER}.dat file02_${COUNTER}.dat
		chmod +x file03_${COUNTER}.sh
		qsub ./file03_${COUNTER}.sh 
		rm -f file03_${COUNTER}.sh
		COUNTER=$((COUNTER+1))
	done
# Notes: perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
