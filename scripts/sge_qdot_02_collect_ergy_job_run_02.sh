#!/bin/bash
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++ COMANDOS ESPECÍFICOS PARA ADMIN. DE COLAS SGE
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++ Current Working Directory
#$ -cwd
# ++ Manda un email si pasa algo con el proceso
#$ -m bea -M martinmendez@mi.unc.edu.ar
# ++ Nombre del proceso
#$ -N mctdhqdotrun
# ++ stdout y stderr apuntan al mismo archivo de salida.
#$ -j y
# ++ Usar shell bash
#$ -S /bin/bash
# ++ Pido memoría RAM para el proceso
#$ -l mem_free=4.2G
# ++ -pe [entorno_paralelo] [cpus] donde:
# ++   [entorno_paralelo] = [smp/make/openmpi/lam/mpich]
# ++   [cpus] = número de cpus
#$ -pe smp ${i}
# ++ NSLOTS -> número de slots
#$ -v OMP_NUM_THREADS=${NSLOTS}
# ++ Reservar slots a medida que otros procesos los liberan
#$ -R y
# ++ Tiempo de CPU (wall clock) que se solicita para el proceso
#$ -l h_rt=4:00:00
# ++ Habilitar checkpoints
#$ -ckpt dmtcp
# ++ Standard output
#$ -o output.log
# ++ Elegir colas especificas para correr
#$ -q long@compute-0-21.local,long@compute-0-22.local

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++        EXPORTACIÓN DE VARIABLES DE ENTORNO
# ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
echo '++++++++++++    START-START-START-START-START   +++++++++++++++++++'
# export DMTCP_SIGCKPT=31
# ++ number of CPU cores to use
export OMP_NUM_THREADS=${NSLOTS}
# ++ Threading schedule
# (consider other schedules as well)
chunksize=128 # sch02,sch03
#export OMP_SCHEDULE="static,default"       # sch01
#export OMP_SCHEDULE="static,${chunksize}"  # sch02
export OMP_SCHEDULE="dynamic,${chunksize}" # sch03
#export OMP_SCHEDULE="guided"               # sch04
#export OMP_SCHEDULE="auto"                 # sch05
# ++ Stack size per thread (you might need to increase this)
export OMP_STACKSIZE="512M"

 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo echo 'lambda: 0.05' '/ COUNTER:' ${COUNTER} '/ num conf:' ${num_conf}
 echo 'OMP_NUM_THREADS:' ${OMP_NUM_THREADS}
 echo 'HOSTNAME: ' ${HOSTNAME} '/ QUEUE: ' ${QUEUE}
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++		COMANDOS PARA CORRER EL PROCESO
# ++				DESDE BASH SHELL
# ++++++++++++++++++++++++++++++++++++++++++++++++++++  
	
cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_02/
rm -Rf double_qd_model_02_${COUNTER}/
mctdh85 -mnd -p V_L 0.9,au -p lambda 0.5 input_file_${COUNTER}.inp
mv double_qd_model_02_${COUNTER}/ configuration_${num_conf}/double_qd_model_02_${COUNTER}/
cd ../../../../scripts/

echo '++++++++++++          END-END-END-END-END       +++++++++++++++++++'
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