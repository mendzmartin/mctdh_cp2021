#!/bin/bash

#echo +++++++++++++++++++++++++++++++++++++++++++++++++
#echo +++			PARAMETERS DECLARATION			+++
#echo +++++++++++++++++++++++++++++++++++++++++++++++++
lambda_min=0.05
lambda_max=1
delta_lambda=0.05

cd ../double_quantum_dot_model/qdot_02/energies_vs_lambda

for j in {0..3};
do
	cd 01_energy_0${j}_vs_lamda
	
	rm -f result_collection_data.dat

	for i in {1..20};
	do
		cd double_qd_model_02_$i
		
		k=$(expr $i - 1)
		lambda=$(echo "scale=2; $lambda_min + $delta_lambda * $k" | bc)
		
		# START EXECUTION
		
		array_data=($(rdrlx -e | tail -n 2 | sed -n '1 p'))
		order="${array_data[1]}"
		beta="${array_data[3]}"
		deltaE="${array_data[9]}"
		result="$lambda ${order} ${beta} ${deltaE}"
		
		# WRITE DATA
		cd ..
		echo $result >> result_collection_data.dat
	done
	
	cd ..
	
done

# Notes:

# compilation:
# 	1) chmod +x script.sh
#	2) ./script.sh
