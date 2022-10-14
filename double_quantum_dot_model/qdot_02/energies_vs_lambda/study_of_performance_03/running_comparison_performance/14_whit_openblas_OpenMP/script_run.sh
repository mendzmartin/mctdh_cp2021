#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

LANG=en_US			# defines the bahaviour otherwise toggling
# PARAMETERS DECLARATION
lambda_min=0.2		# valor mínimo
lambda_max=0.2	    # valor maximo
delta_lambda=0.05	# paso

export OMP_NUM_THREADS=2 # number of CPU cores to use
# # ++ Threading schedule
chunksize=512
export OMP_SCHEDULE="static,${chunksize}"


export OPENBLAS_NUM_THREADS=1
#export openblas_set_num_threads(1)
export USE_THREAD=0
export USE_LOCKING=1

for i in $(seq ${lambda_min} ${delta_lambda} ${lambda_max})
	do
    rm -Rf result_double_qd_model_02_lambda${i}/
    sed '2 s/${i}/'${i}'/g' input_file.inp > input_file_${i}.inp
    mctdh86P -mnd -w -p V_L 0.9,au -p lambda ${i} input_file_${i}.inp
    rm -f input_file_${i}.inp
done

echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '++++               END-END-END-END-END                ++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

########################################################################

# NOTE: Some executables are enabled to use shared-memory parallelization
#       via OpenMP directives. To make use of this, you should set the
#       following environment variables in your *execution* environment:

#       OMP_NUM_THREADS=<n>       # number of CPU cores to use

#       OMP_SCHEDULE="dynamic,1"  # threading schedule
#                                 # (consider other schedules as well)

#       OMP_STACKSIZE="64M"       # stack size per thread
#                                 # (you might need to increase this)

# HINT: For performance optimization one might also consider seting
#       the variables OMP_PLACES and OMP_PROC_BIND.

#       To set the environment variables it is convenient to edit
#       and source the file /home/mendez/MCTDH/mctdh86.2/install/OMPvars.sh

#       It is recommended to link to a parallel version of LAPACK
#       for 'mcpotfit' and 'natpot2cpd' as these make extensive use
#       of linear algebra tools. See -x option of 'compile'.

# NOTE: Within MCTDH 8.6 at present, only the ML part of mctdh86 as well
#       as the programs 'vminmax', 'mccpd', 'mcpotfit', 'potfit' and
#       'natpot2cpd' support OpenMP. 'Potfit' only when re-fitting a PES
#       file. For all other programs the -P option makes no difference.
#       Note that the excecutables produced by 'compile -P' carry the
#       extension P. Depending on your installation you might need to
#       set 'ulimit -s unlimited' in execution shell.

########################################################################

