#!/bin/bash
LANG=en_US # defines the bahaviour otherwise toggling
# PARAMETERS DECLARATIONS	
val_min=2;val_max=5;delta_val=1
# EXECUTION
for i in $(seq $val_min $delta_val $val_max)
	do
		# change values outside according to looped variables
		sed 's/${i}/'${i}'/g' sge_qdot_02_collect_ergy_job_run_03.sh > file_01_${i}.txt
		sed '32,35 s/#'${i}'/''/g' file_01_${i}.txt > file_02_${i}.sh
		rm -f file_01_${i}.txt	 # remove unnecessary data
		chmod +x file_02_${i}.sh # give permission
		qsub ./file_02_${i}.sh   # run script
		rm -f file_02_${i}.sh 	 # remove unnecessary data
	done
# Notes:
# perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
