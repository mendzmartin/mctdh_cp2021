#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

LANG=en_US			# defines the bahaviour otherwise toggling
# PARAMETERS DECLARATION
lambda_min=0.5		# valor mínimo
lambda_max=0.5	    # valor maximo
delta_lambda=0.05	# paso

export OMP_NUM_THREADS=4 # number of CPU cores to use
# # ++ Threading schedule
#chunksize=128                              # sch02,sch03 (consider other schedules as well)
export OMP_SCHEDULE="auto"
export OMP_STACKSIZE="512M"                # Stack size per thread (you might need to increase this)


export OPENBLAS_NUM_THREADS=1
#export openblas_set_num_threads(1)
export USE_THREAD=0
export USE_LOCKING=1

for i in $(seq ${lambda_min} ${delta_lambda} ${lambda_max})
	do
    rm -Rf result_double_qd_model_02_lambda${i}/
    sed '2 s/${i}/'${i}'/g' input_file.inp > input_file_${i}.inp
    mctdh86 -mnd -w -p V_L 0.9,au -p lambda ${i} input_file_${i}.inp
    rm -f input_file_${i}.inp
done

echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '++++               END-END-END-END-END                ++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
