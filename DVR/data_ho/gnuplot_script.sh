#!/usr/bin/gnuplot

# Potential only #

set terminal png size 1024,1024
set output 'potential.png'
set xlabel 'ort[g2]'
set ylabel 'V'
unset key
set xrange [-50:50]
set yrange []
set title "1 Potential of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'potential.dat' using 1:2 with lines

# Wave functions only #

set terminal png size 1024,1024
set output 'wave_function_o.png'
set xlabel 'ort[g2]'
set ylabel 'Psi'
unset key
set xrange [-10:10]
set yrange [0:0.2]
set title "1 Wave Functions odd of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'wave_function_o.dat' using 1:2 with lines, \
'wave_function_o.dat' using 1:3 with lines, \
'wave_function_o.dat' using 1:4 with lines, \
'wave_function_o.dat' using 1:5 with lines, \
'wave_function_o.dat' using 1:6 with lines

set terminal png size 1024,1024
set output 'wave_function_e.png'
set xlabel 'ort[g2]'
set ylabel 'Psi'
unset key
set xrange [-10:10]
set yrange [0:0.2]
set title "1 Wave Functions even of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'wave_function_e.dat' using 1:2 with lines, \
'wave_function_e.dat' using 1:3 with lines, \
'wave_function_e.dat' using 1:4 with lines, \
'wave_function_e.dat' using 1:5 with lines, \
'wave_function_e.dat' using 1:6 with lines

# Potential and wave functions #

set terminal png size 1024,1024
set output 'potential_wave_function_o.png'
set xlabel 'ort[g2]'
set ylabel 'V, Psi'
unset key
set xrange [-5:5]
set yrange [0:0.5]
set title "1 Potential and Wave Functions odd of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'potential.dat' using 1:2 with lines, \
'wave_function_o.dat' using 1:2 with lines, \
'wave_function_o.dat' using 1:3 with lines, \
'wave_function_o.dat' using 1:4 with lines, \
'wave_function_o.dat' using 1:5 with lines, \
'wave_function_o.dat' using 1:6 with lines

set terminal png size 1024,1024
set output 'potential_wave_function_e.png'
set xlabel 'ort[g2]'
set ylabel 'V, Psi'
unset key
set xrange [-5:5]
set yrange [0:0.5]
set title "1 Potential and Wave Functions even of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'potential.dat' using 1:2 with lines, \
'wave_function_e.dat' using 1:2 with lines, \
'wave_function_e.dat' using 1:3 with lines, \
'wave_function_e.dat' using 1:4 with lines, \
'wave_function_e.dat' using 1:5 with lines, \
'wave_function_e.dat' using 1:6 with lines

# Eigenvals #

set terminal png size 1024,1024
set output 'eigenvals_vs_beta.png'
set xlabel 'Beta'
set ylabel 'E'
unset key
set xrange [0.01:0.1]
set yrange [0:5]
set title "1 Eigenvals even/odd vs Beta with Sine DVR" offset 0,-0.5
plot 'eigenvals_e_vs_beta.dat' using 1:2 with lines, \
'eigenvals_o_vs_beta.dat' using 1:2 with lines

# eigenvectors #

set terminal png size 1024,1024
set output 'eigenvect_o.png'
set xlabel 'ort[g2]'
set ylabel 'H[g2]'
unset key
set xrange [-10:10]
set yrange [-0.5:0.5]
set title "1 Eigenvectors odd of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'eigenvect_o.dat' using 1:2 with lines, \
'eigenvect_o.dat' using 1:3 with lines, \
'eigenvect_o.dat' using 1:4 with lines, \
'eigenvect_o.dat' using 1:5 with lines, \
'eigenvect_o.dat' using 1:6 with lines

# eigenvectors #

set terminal png size 1024,1024
set output 'eigenvect_e.png'
set xlabel 'ort[g2]'
set ylabel 'H[g2]'
unset key
set xrange [-10:10]
set yrange [-0.5:0.5]
set title "1 Eigenvectors even of Harmonic Oscilator with Sine DVR" offset 0,-0.5
plot 'eigenvect_e.dat' using 1:2 with lines, \
'eigenvect_e.dat' using 1:3 with lines, \
'eigenvect_e.dat' using 1:4 with lines, \
'eigenvect_e.dat' using 1:5 with lines, \
'eigenvect_e.dat' using 1:6 with lines

# run: ./gnuplot.script.sh
