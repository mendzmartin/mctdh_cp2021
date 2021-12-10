#!/bin/bash

# take from 5-row to 10-row from xxxx file and save data in xxxx.dat
# -F, tells awk to use , as the field separator on input. This is equivalent to but much briefer than BEGIN {FS = ","}.
# NR := Number of Record
# print $1,$3 tells awk to print the first and the third columns.

awk -F, 'NR==5, NR==24 {print $1,$3}' veigen_X1 >> first_20_eigenvalues-V_L-0.6_.dat
