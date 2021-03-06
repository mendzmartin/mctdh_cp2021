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
#$ -N run_${COUNTER}

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
#$ -o output.log

# Elegir colas especificas para correr
#$ -q long@compute-0-21.local,long@compute-0-22.local
##$ -q long@compute-0-7.local,long@compute-0-4.local,long@compute-0-5.local

# Excluye este/estos nodos
##$ -l h=!compute-0-0&!compute-0-1&!compute-0-2&!compute-0-3&!compute-0-4&!compute-0-5&!compute-0-6&!compute-0-7&!compute-0-8&!compute-0-9&!compute-0-10&!compute-0-11&!compute-0-12&!compute-0-13&!compute-0-14&!compute-0-15&!compute-0-16&!compute-0-17&!compute-0-18&!compute-0-19&!compute-0-20&!compute-0-23&!compute-0-24&!gpu-compute-0-0&!gpu-compute-0-1&!gpu-compute-0-2

#################################################################
### EXPORTACIÓN DE VARIABLES DE ENTORNO
#################################################################
#LANG=en_US
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

echo '**********************************START********************************************'
echo '**********************************START********************************************'
echo echo 'lambda:' ${i} '/ COUNTER:' ${COUNTER} '/ num conf:' ${num_conf}
echo 'OMP_NUM_THREADS:' ${OMP_NUM_THREADS}
echo 'HOSTNAME: ' ${HOSTNAME} '/ QUEUE: ' ${QUEUE}
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++		COMANDOS PARA CORRER EL PROCESO			++
# ++				DESDE BASH SHELL				++
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_01/
    rm -Rf double_qd_model_02_${COUNTER}/
    sed '2 s/${COUNT}/'${COUNTER}'/g' input_file.inp > input_file_${COUNTER}.inp
    mctdh85 -mnd -p V_L 0.9,au -p lambda ${i} input_file_${COUNTER}.inp
    rm -f input_file_${COUNTER}.inp
    mv double_qd_model_02_${COUNTER}/ configuration_${num_conf}/double_qd_model_02_${COUNTER}/
cd ../../../../scripts/
echo '**********************************FINISH********************************************'
echo '**********************************FINISH********************************************'
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
#	qdel -u username
