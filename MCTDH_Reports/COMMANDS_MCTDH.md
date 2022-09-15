## Initial sequence

* ```rm -rf directory_name/```						->	remove the directory with the program outs.
* ```mctdh85 -w -mnd input_file.inp```				->	run the input_file (uncomment the geninwf keyword and comment the propagation keyword).
* ```cd directory_name/```							->	enter to the directory with the program outs.
* ```vi log```										->	show the log file to see what the program did.
* ```showsys85 -rst```								->	the flag -rst is added to say to mctdh that show the restar initial wave function.
* ```mctdh85 -w input_file.inp```					->	run again the input file (uncomment the keyword propagation and comment the keyword eninwf).
* ```showd1d85 -a f1```								->	show the temporal evolution of the coordenate 1 (f1 denote GOF 1) of the probability density. Press enter to see the evolution.
* ```showd1d85 -a f2```								->	show the temporal evolution of the coordenate 2 (f2 denote GOF 2) of the probability density. Press enter to see the evolution.
* ```mctdh85 -w -c -tfinal 4.0 input_file.inp```	->	run again the input file (uncomment the propagation keyword and comment the geninwf keyword). The flag ```-c``` allow that mctdh take the restart data and will continue the propagation with that initial wave function. The flag ```-tfinal 4.0``` denote that the program run until the final time equal to 4 femtosecond (1[fs] = 10^-15[s]).

## flags to run with mctdh85 command

* ```-p alpha 1.1 input_file.inp```	-> -p is used to assign the 1.1 value to alpha variable for use it in operator_file.op.

## scripts

* ```showsys85```	->	Enables 2D plotting of the wavefunction or PES.
* ```showd1d85```	->	To selectively plot 1-dimensional densitites.
* ```crosscorr85```	->	Calculates the cross-correlation function c(t) = <psi_ref(0)|psi(t)>.
* ```plauto```		->	Plot of the absolut value of the autocorrelation function.
* ```autospec85```	->	Computation of the spectrum by Fourier-transforming the autocorrelation function.
* ```plspec```		->	Plot of the spectrum obtained from a fourier transform of the autocorrelation function.
* ```plnat```		->	Natural population. Also we can use the script rdcheck85. Plot of the natural populations for a given state and mode.
* ```rdcheck85```	->	Reads the check-file. Analyses the state population and natural weights.


## Notes

* ```directory_name/restart```	->	have the initial wave function (at zero time).
* ```directory_name/oper```		->	have information about operators.
