#!/bin/bash

#################################################################
### Purpose: script para correr en cluster bandurria
#################################################################

#################################################################
### COMANDOS ESPECÍFICOS PARA ADMINISTRADOR DE COLAS SGE
#################################################################

# Current Working Directory. Directorio actual es el raiz.
# Se trabajará por defecto en el directorio indicado,
#   con los ficheros incluidos en él.
#$ -cwd

# Manda un email si pasa algo con el proceso
##$ -m eas -M martinmendez@mi.unc.edu.ar
#$ -M martinmendez@mi.unc.edu.ar 
#$ -m bea

# Nombre del proceso.
# Por defecto toma el nombre del script que se ejecuta.
#$ -N mctdh_qdot_run

# Especifica si la salida de error de la tarea a ejecutar va a ser
#   la salida de error de SGE, es decir, si stdout y stderr apuntan
#   al mismo archivo de salida.
#$ -j y

# Usar shell específico (en este caso bash) para el proceso a correr
#$ -S /bin/bash

# Pido memoría RAM para el proceso
#  si quiero 4GB reservo un poco más
#  (por ej. si necesito 2GB recervo 2.2GB)
#$ -l mem_free=4.2G

# Obligatorio en procesos paralelos (-pe [entorno_paralelo] [cpus])
#  donde [entorno_paralelo] = [smp/make/openmpi/lam/mpich]
#  donde [cpus] = número de cpus
#$ -pe smp 8

# NSLOTS -> Variable de entorno que especifica el número de slots
#           de la cola asignados al trabajo paralelo.
#$ -v OMP_NUM_THREADS=${NSLOTS}

# Reservar slots a medida que otros procesos los liberan
#$ -R y

# Tiempo de CPU (wall clock) que se solicita para el proceso
#  h_rt=[h:min:sec]
#$ -l h_rt=4:00:00

# Especificar que el proceso es capaz de hacer checkpoints
#$ -ckpt dmtcp

# Eligir el archivo output.log para que allí se escriba
#  el standard output (salida)
#$ -o output_run.log

# Pido la cola sumo (tiene infiniband)
# Puedo usar otras colas si no requiero infiniband
##$ -q sumo

#################################################################
### EXPORTACIÓN DE VARIABLES DE ENTORNO
#################################################################

# Exportar al environment las variables.

# export DMTCP_SIGCKPT=31
# number of CPU cores to use
 export OMP_NUM_THREADS=${NSLOTS}
# Threading schedule
# (consider other schedules as well)
# export OMP_SCHEDULE="dynamic,128"
# Stack size per thread
# (you might need to increase this)
# export OMP_STACKSIZE="512M"

 echo '######################################################'
 echo 'started run' && date
 echo 'OMP_NUM_THREADS :' ${OMP_NUM_THREADS}
                                          
#################################################################
### COMANDOS PARA CORRER EL PROCESO DESDE BASH SHELL
#################################################################
	
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance/

	mctdh85 -mnd -p V_L 0.9,au -p lambda ${i} input_file.inp

	# START COLLECTION OF ENERGIES
	cd double_qd_model_02/
	array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
	energy_part1="${array_energy[4]}"
	energy_part2="${array_energy[5]}"
	result="${i} ${energy_part1}${energy_part2}"
	
	# WRITE DATA
	cd ..
	echo ${result} >> result_energy_vs_lambda.dat
	
	# SAVE DATA FOLDER
	mv double_qd_model_02/ configuration_04/double_qd_model_02_${COUNTER}/

cd ../../../../scripts/

#################################################################
### NOTAS Y/O COMENTARIOS
#################################################################

# " #$ " simple numeral con pesos es un comando
# " #  " numeral solo es un comentario
# dentro de bandurria usar el comando [/home/user]
# 	qsub sge_script.sh 	-> para encolar el trabajo
# 	qstat 			-> para ver los trabajos encolados
# 	qdel jobID		-> para remover un trabajo de la cola
#	qacct -j jobID 		-> report and account for Sun Grid Engine usage
