#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
# ++++++++++++++++++++++++++++++++++++++++++++++++++++
# ++        EXPORTACIÓN DE VARIABLES DE ENTORNO
# ++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 export OMP_NUM_THREADS=4 # number of CPU cores to use
# ++ Threading schedule
 chunksize=128
 export OMP_SCHEDULE="dynamic,${chunksize}"
 export OMP_STACKSIZE="512M"

 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
 echo 'lambda:           0.5'
 echo 'OMP_NUM_THREADS:     ' ${OMP_NUM_THREADS}
 echo 'OMP_SCHEDULE:        ' ${OMP_SCHEDULE}
 echo 'OMP_STACKSIZE:       ' ${OMP_STACKSIZE}
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

