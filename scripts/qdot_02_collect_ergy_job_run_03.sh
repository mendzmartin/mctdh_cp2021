#!/bin/bash
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '+++++         START-START-START-START-START          +++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda/study_of_performance_03/pc_famaf_martin/
    rm -Rf 01_result_double_qd_model_02/
    export OPENBLAS_NUM_THREADS=4
    mctdh85 -mnd -w -p V_L 0.9,au -p lambda 0.5 input_file.inp
cd ../../../../../scripts/

echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo '++++               END-END-END-END-END                ++++'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
