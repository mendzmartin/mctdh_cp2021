#!/bin/bash
LANG=en_US # defines the bahaviour otherwise toggling
# PARAMETERS DECLARATIONS	
cores_min=1
cores_max=4
delta_cores=1
# EXECUTION
for i in $(seq $cores_min $cores_lambda $cores_max)
	do
		# change values outside according to looped variables
		sed 's/${i}/'${i}'/g' sge_qdot_02_collect_ergy_job_run_02.sh > file_01_${i}.sh
		# remove unnecessary data, give permission and run script
		chmod +x file_01_${i}.sh
		qsub ./file_01_${i}.sh 
		rm -f file_01_${i}.sh
	done
# Notes:
# perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
