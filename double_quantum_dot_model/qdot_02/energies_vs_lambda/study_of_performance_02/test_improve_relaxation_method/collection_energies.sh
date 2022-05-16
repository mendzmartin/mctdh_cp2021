#!/bin/bash
LANG=en_US # defines the bahaviour otherwise toggling
for i in $(seq 1 1 3)
	do
    cd double_qd_model_02_1_v1_0${i}_02/
        if [ ${i} -eq 3 ];then
            array_energy=($(rdrlx | tail -n 4 | sed -n '1 p'))
            energy_part1="${array_energy[5]}"
            result="conf0${i} ${energy_part1}"
        fi
        if [ ${i} -eq 2 ];then
            array_energy=($(rdrlx | tail -n 4 | sed -n '1 p'))
            energy_part1="${array_energy[4]}"
            energy_part2="${array_energy[5]}"
            result="conf0${i} ${energy_part1}${energy_part2}"
        fi
        if [ ${i} -eq 1 ];then
            array_energy=($(rdrlx | tail -n 2 | sed -n '1 p'))
            energy_part1="${array_energy[4]}"
            energy_part2="${array_energy[5]}"
            result="conf0${i} ${energy_part1}${energy_part2}"
        fi
    cd ../
	    echo ${result} >> result_energies_02.dat
    done