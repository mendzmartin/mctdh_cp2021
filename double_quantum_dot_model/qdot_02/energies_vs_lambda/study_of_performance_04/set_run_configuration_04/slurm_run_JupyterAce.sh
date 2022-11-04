#!/bin/bash

# +++ Metadatos para ejecutar con slurm
# +++ Nombre para identificar el trabajo. Por defecto es el nombre del script
#SBATCH --job-name=MCTDHcp2021
# +++ Solicita N cores, por defecto se asignan consecutivamente dentro de un nodo. Si N excede la cantidad de cores continúa en otro nodo
#SBATCH --ntasks-per-node=${i}
# +++ Especifico en cuantos hilos correra cada uno de los procesos anteriores
#SBATCH --cpus-per-task=${i}
# +++ Especifico que no quiero a nadie más en el nodo cuando corra esta tarea
#SBATCH --exclusive
# +++ Envía un correo cuando el trabajo finaliza correctamente o por algún error
#SBATCH --mail-type=END
#SBATCH --mail-user=martinmendez@mi.unc.edu.ar
# +++ La linea siguiente es ignorada por Slurm porque empieza con ##
##SBATCH --mem-per-cpu=4G # cantidad de memoria por core

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# set threads to use in OpenBLAS with OpenMP
export OMP_NUM_THREADS=${i}

# schedule of OpenBLAS with OpenMP
export OMP_SCHEDULE="static,512"
export OMP_STACKSIZE="512M"

# threads distribution configuration to OpenBLAS
export OPENBLAS_NUM_THREADS=1
export USE_THREAD=0
export USE_LOCKING=1

# set name of results from MCTDH package and remove existed data
name_folder="result_2QDot3e_NumCores${i}"
rm -Rf ${name_folder}/

# change variable in input file to MCTDH package
name_InputFile="input_file_Lambda02_NumCores${i}.inp"
sed '2,5 s/${i}/'${i}'/g' input_file.inp > ${name_InputFile}

# srun perf stat -e cycles,instructions,cache-references,cache-misses -r 2 mctdh86P -mnd -w -p V_L 0.9,au -p lambda 0.2 ${name_InputFile}
srun perf stat -e cycles,instructions,cache-references,cache-misses -r 2 mctdh86 -mnd -w -p V_L 0.9,au -p lambda 0.2 ${name_InputFile}
            
rm -f ${name_InputFile}
