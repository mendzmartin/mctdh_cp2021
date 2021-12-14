#!/bin/bash

# take from 5-row to 10-row from xxxx file and save data in xxxx.dat
# -F, tells awk to use , as the field separator on input. This is equivalent to but much briefer than BEGIN {FS = ","}.
# NR := Number of Record
# print $3 tells awk to print the third column.

# awk -F"        " 'NR==5, NR==13 {print $3}' veigen_X1 >> first_20_eigenvalues-V_L-0.4_.dat

#awk -F"        " 'NR==5, NR==13 {print $3}' veigen_X1
#awk -F"        " 'NR==14, NR==16 {print $3}' veigen_X1
#awk -F"       " 'NR==17, NR==24 {print $3}' veigen_X1


awk 'NR==5, NR==20 {print $3}' veigen_X1 >> first_20_eigenvalues-V_L-0.4_.dat
