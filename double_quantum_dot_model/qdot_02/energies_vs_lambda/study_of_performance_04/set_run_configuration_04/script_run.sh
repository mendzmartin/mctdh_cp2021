#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

LANG=en_US			# defines the bahaviour otherwise toggling
# set Cores number range
NumCores_min=1		# valor mínimo
NumCores_max=28	    # valor maximo
delta_NumCores=1	# paso

for i in $(seq ${NumCores_min} ${delta_NumCores} ${NumCores_max})
do
    name_RunScriptJupyterAce="slurm_run_JupyterAce${i}.sh"
    sed 's/${i}/'${i}'/g' slurm_run_JupyterAce.sh > ${name_RunScriptJupyterAce}
    chmod +x ${name_RunScriptJupyterAce}
    ./${name_RunScriptJupyterAce}
    rm -f ${name_RunScriptJupyterAce}
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

## RUN COMMAND: ./script_run.sh > result_benchmark_stacksize_KiloBytes.dat

# ERROR: Access to performance monitoring and observability operations is limited.
# sudo -i
# sudo password
# echo -1 > /proc/sys/kernel/perf_event_paranoid
# exit