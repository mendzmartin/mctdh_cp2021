#!/bin/bash

#################################################################
### Purpose: script para correr en cluster bandurria
#################################################################

#################################################################
### COMANDOS ESPECÍFICOS PARA ADMINISTRADOR DE COLAS SGE
#################################################################

### Current Working Directory. Directorio actual es el raiz.
#$ -cwd
### Manda un email si pasa algo con el proceso
#$ -m bea -M martinmendez@mi.unc.edu.ar
### Nombre del proceso.
#$ -N mctdh_qdot_dis
### stdout y stderr apuntan
#$ -j y
### Usar bash shell
#$ -S /bin/bash
### Pedir memoria RAM
#$ -l mem_free=4.2G
### Configurar proceso paralelo (-pe [entorno_paralelo] [cpus])
#$ -pe smp 8
### asignar numero de slots
#$ -v OMP_NUM_THREADS=${NSLOTS}
### Reservar slots a medida que otros procesos los liberan
#$ -R y
### Tiempo de CPU (wall clock)
#$ -l h_rt=4:00:00
### establecer checkpoints
#$ -ckpt dmtcp
### Standard output (salida)
#$ -o output_dis.log
### Pedir cola sumo (tiene inifnityband)
##$ -q sumo

#################################################################
### EXPORTACIÓN DE VARIABLES DE ENTORNO
#################################################################

# number of CPU cores to use
 export OMP_NUM_THREADS=${NSLOTS}

 echo '+++++++++++++++++++++++++++++++++++++++++++++++++'
 echo 'started run' && date
 echo 'OMP_NUM_THREADS :' ${OMP_NUM_THREADS}
 echo '+++++++++++++++++++++++++++++++++++++++++++++++++'
                                          
#################################################################
### COMANDOS PARA CORRER EL PROCESO DESDE BASH SHELL
#################################################################

# defines the bahaviour otherwise toggling
LANG=en_US

# +++++++++++++++++++++++++++++++++++++++++++++++++
# +++			PARAMETERS DECLARATION			+++
# +++++++++++++++++++++++++++++++++++++++++++++++++

lambda_min=0.05
lambda_max=1
delta_lambda=0.05
COUNTER=1

# +++++++++++++++++++++++++++++++++++++++++++++++++
# +++			EXECUTION						+++
# +++++++++++++++++++++++++++++++++++++++++++++++++

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	# remove existing data
	rm -f result_energy_vs_lambda.dat
	rm -Rf double_qd_model_02/

cd ../../../../scripts/
	for i in $(seq $lambda_min $delta_lambda $lambda_max)
		do
		# change values accordingto for loop and COUNTER
		sed '91 s/${i}/'${i}'/' sge_qdot_02_collect_ergy_job_run.sh >> intermediate_file_01.txt
		sed '98 s/${i}/'${i}'/' intermediate_file_01.txt >> intermediate_file_02.txt
		sed '105 s/${COUNTER}/'${COUNTER}'/' intermediate_file_02.txt >> sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		
		# remove unnecessary data, give permission and run script
		rm -f intermediate_file_01.txt intermediate_file_02.txt
		chmod +x sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		./sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		rm -f sge_qdot_02_collect_ergy_job_run_${COUNTER}.sh
		
		COUNTER=$((COUNTER+1))
	done

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/
	mv result_energy_vs_lambda.dat configuration_04/result_energy_vs_lambda.dat

# Notes:

# compilation:
# 	1) chmod +x script.sh
# 	2) ./script.sh
# performance
# 	1) perf stat -e cpu-clock,cpu-cycles,instructions,cache-references,cache-misses
