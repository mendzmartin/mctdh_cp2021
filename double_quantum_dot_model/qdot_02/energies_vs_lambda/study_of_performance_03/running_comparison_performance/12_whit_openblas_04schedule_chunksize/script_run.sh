#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

#LANG=en_US			# defines the bahaviour otherwise toggling
# PARAMETERS DECLARATION
lambda=0.2
pow_min=7
pow_max=10
delta_pow=1

export OMP_NUM_THREADS=2 # number of CPU cores to use

export OPENBLAS_NUM_THREADS=1
#export openblas_set_num_threads(1)
export USE_THREAD=0
export USE_LOCKING=1

for i in $(seq ${pow_min} ${delta_pow} ${pow_max})
	do
    # # ++ Threading schedule
    chunksize=$((2**${i}))
    export OMP_SCHEDULE="dynamic,${chunksize}"
    rm -Rf result_double_qd_model_02_chunksz${chunksize}/
    sed '2 s/${chunksize}/'${chunksize}'/g' input_file.inp > input_file_${chunksize}.inp
    mctdh86 -mnd -w -p V_L 0.9,au -p lambda ${lambda} input_file_${chunksize}.inp
    rm -f input_file_${chunksize}.inp
    echo 'Finished run for chunksize = ' ${chunksize}
done

echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '++++               END-END-END-END-END                ++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
