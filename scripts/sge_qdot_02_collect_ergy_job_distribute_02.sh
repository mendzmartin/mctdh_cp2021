#!/bin/bash
LANG=en_US # defines the bahaviour otherwise toggling
# PARAMETERS DECLARATIONS	
cores_min=1
cores_max=4
delta_cores=1
# EXECUTION
for i in $(seq $cores_min $delta_cores $cores_max)
	do
		# change values outside according to looped variables
		sed 's/${i}/'${i}'/g' sge_qdot_02_collect_ergy_job_run_02.sh > file_01_${i}.sh
		chmod +x file_01_${i}.sh	# give permission
		qsub ./file_01_${i}.sh  	# run script
		rm -f file_01_${i}.sh		# remove unnecessary data
	done
# Notes:
# perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
