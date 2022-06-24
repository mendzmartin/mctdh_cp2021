#!/bin/bash
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++ COMANDOS ESPECÍFICOS PARA ADMIN. DE COLAS SGE
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
#$ -cwd                                               # Current Working Directory
#$ -m bea -M martinmendez@mi.unc.edu.ar               # Manda un email si pasa algo con el proceso
#$ -N run_1                                        	  # Nombre del proceso
#$ -j y                                               # stdout y stderr apuntan al mismo archivo de salida.
#$ -S /bin/bash                                       # Usar shell bash
#$ -l mem_free=4.2G                                   # Pido memoría RAM para el proceso
#$ -pe smp 1                                          # -pe [entorno_paralelo] [cpus] donde:
                                                      #   [entorno_paralelo] = [smp/make/openmpi/lam/mpich]
                                                      #   [cpus] = número de cpus
#$ -v OMP_NUM_THREADS=${NSLOTS}                       # NSLOTS -> número de slots
#$ -R y                                               # Reservar slots a medida que otros procesos los liberan
#$ -l h_rt=4:00:00                                    # Tiempo de CPU (wall clock) que se solicita para el proceso
#$ -ckpt dmtcp                                        # Habilitar checkpoints
#$ -o output_bandurria.log                         	  # Standard output
#$ -q long@compute-0-21.local,long@compute-0-22.local # Elegir colas especificas para correr

echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++        EXPORTACIÓN DE VARIABLES DE ENTORNO
# ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
# export DMTCP_SIGCKPT=31
# export OMP_NUM_THREADS=${NSLOTS} # number of CPU cores to use
# ++ Threading schedule
# chunksize=128
# export OMP_SCHEDULE="dynamic,${chunksize}"
# export OMP_STACKSIZE="512M"

 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo 'lambda:           0.5'
 echo 'num_conf:        ' ${i}
 #echo 'OMP_NUM_THREADS: ' ${OMP_NUM_THREADS}
 echo 'HOSTNAME:        ' ${HOSTNAME}
 echo 'QUEUE:           ' ${QUEUE}
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++		COMANDOS PARA CORRER EL PROCESO
# ++				DESDE BASH SHELL
# ++++++++++++++++++++++++++++++++++++++++++++++++++++  
rm -Rf result_mctdh_01/
mctdh85 -mnd -p V_L 0.9,au -p lambda 0.5 input_file.inp
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '++++               END-END-END-END-END                ++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++ NOTAS Y/O COMENTARIOS
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++ " #$ " simple numeral con pesos es un comando
# ++ " #  " numeral solo es un comentario
# ++ dentro de bandurria usar el comando [/home/user]
# ++ 	qsub sge_script.sh 	-> para encolar el trabajo
# ++ 	qstat 			-> para ver los trabajos encolados
# ++ 	qdel jobID		-> para remover un trabajo de la cola
# ++	qacct -j jobID 		-> report and account for Sun Grid Engine usage
# ++	qdel -u username
