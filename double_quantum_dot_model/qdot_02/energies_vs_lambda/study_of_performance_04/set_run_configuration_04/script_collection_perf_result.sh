#!/bin/bash

rm -f result_collection_total_timing_data.dat

for i in {1..28}
do
    cd result2QDot3eCor${i}/
    ArrayData=($(cat slurm${i}.out | tail -n 3))
    Result="${i} ${ArrayData}"
    cd ..
    echo ${Result} >> result_collection_total_timing_data.dat
done