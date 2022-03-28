#!/bin/bash

#################################################################
### COMANDOS PARA ADMINISTRADOR DE COLAS SGE
#################################################################

#  Current Working Directory. Directorio actual es el raiz.
#  Se trabajará por defecto en eldirectorio indicado, con los ficheros incluidos en él.
#$ -cwd

#  Manda un email si pasa algo con el proceso
#$ -m eas -M martinmendez@mi.unc.edu.ar

#  Nombre del proceso. Por defecto toma el nombre del script que se ejecuta.
#$ -N mctdh_cp2021

#  Especifica si la salida de error de la tarea a ejecutar va a ser la salida de error de SGE.
#  Es decir, si stdout y stderr al mismo archivo de salida.
#$ -j y

#  Usar bash como shell para el proceso a correr
#$ -S /bin/bash

#  Pido la cola sumo (tiene infiniband) (Puedo usar otras colas si no requiero infiniband)
##$ -q sumo

#  Pido 2GB RAM para el proceso (reservo un poco más)
#$ -l mem_free=2.2G

#  -pe [entorno_paralelo] [cpus] (obligatorio en procesos paralelos)
##$  -pe [make/openmpi/lam/mpich] [cpus]
#$ -pe smp 8
#  NSLOTS -> Variable de entorno. Número de slots de la cola asignados al trabajo paralelo.
#$ -v OMP_NUM_THREADS={$NSLOTS}

#  Reservar slots a medida que otros procesos los liberan
#$ -R y

#  tiempo de CPU (wall clock) que se solicita para el proceso
#$ -l h_rt=2:00:00

#  Especificar que el proceso es capaz de hacer checkpoints
#$ -ckpt dmtcp

# Eligir el archivo output.log para que allí se escriba el standard output (salida)
#$ -o output.log

#################################################################
### EXPORTACIÓN DE VARIABLES DE ENTORNO
#################################################################

#aveces es necesario exportar al environment las variables.
#export DMTCP_SIGCKPT=31
export OMP_NUM_THREADS=$NSLOTS            # number of CPU cores to use
echo 'OMP_NUM_THREADS :' $OMP_NUM_THREADS
export OMP_SCHEDULE="dynamic,128"         # threading schedule
                                          # (consider other schedules as well)
export OMP_STACKSIZE="512M"               # stack size per thread
                                          # (you might need to increase this)

#################################################################
### COMANDOS USUALES PARA CORRER EL PROCESO DESDE LA TERMINAL
#################################################################

./qdot_02_collection_energy.sh

#################################################################
### NOTAS Y/O COMENTARIOS
#################################################################

# " #$ " simple numeral con pesos es un comando
# " # " numeral solo es un comentario
# dentro de bandurria usar el comando [/home/user]
# 	qsub sge_dot_02_collection_energy.sh 	-> para encolar el trabajo
# 	qstat 					-> para ver los trabajos encolados
# 	qdel jobID				-> para remover un trabajo de la cola
