# brief description about each file
* test_oscillator_01
* test_oscillator_02
* test_oscillator_03
* test_oscillator_04
* test_oscillator_05
* test_oscillator_06
	* 01_plspec
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 0.0 | q | q				(NO perturbative potential)
		* X1 HO 1.2 0 1 1 pop=1		(initial wave function)
		* X2 HO -1.5 0 1 1 pop=1	(initial wave function)
	* 02_autospec85_comparison_01_tauiexp
		*	idem 01_plspec adjusting the tau and iexp parameters
* test_oscillator_07
	* 01_plspec_lamda01_01
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 0.1 | q | q				(perturbative potential)
		* X1 HO 1.2 0 1 1 pop=1		(initial wave function)
		* X2 HO -1.5 0 1 1 pop=1	(initial wave function)
	* 01_plspec_lamda01_02
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 0.1 | q | q				(perturbative potential)
		* X1 HO 0 0 1 1 pop=1		(initial wave function)
		* X2 HO 0 0 1 1 pop=1		(initial wave function)
	* 01_plspec_lamda01_02
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 0.1 | q | q				(perturbative potential)
		* X1 HO 5 0 1 1 pop=1		(initial wave function)
		* X1 HO -5 0 1 1 pop=1		(initial wave function)
	* 02_plspec_lamda05
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 0.5 | q | q				(perturbative potential)
		* X1 HO 1.2 0 1 1 pop=1		(initial wave function)
		* X2 HO -1.5 0 1 1 pop=1	(initial wave function)
	* 03_plspec_lamda1
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 1 | q | q					(perturbative potential)
		* X1 HO 1.2 0 1 1 pop=1		(initial wave function)
		* X2 HO -1.5 0 1 1 pop=1	(initial wave function)
* test_oscillator_08
	* 01_plspec
		* 	X1	=	10; X2	=	10	(population SPFs)
		* run the script plspec
		* 1.625	|	q^2	|	1		(harmonic potential)
		* 1.625	|	1	|	q^2		(harmonic potential)
		* 2.5	|	q	|	q		(perturbative potential)
		* X1 HO 1.2 0 1.8 1 pop=1	(initial wave function)
		* X2 HO -1.5 0 1.8 1 pop=1	(initial wave function)
	* 02_plnat
		* 	X1	=	10; X2	=	10	(population SPFs)
	* 03_plnat
		* 	X1	=	5; X2	=	5	(population SPFs)
	* 04_plnat
		* 	X1	=	2; X2	=	2	(population SPFs)
	* 05_plnat
		* 	X1	=	1; X2	=	1	(population SPFs)
	* 06_plnat_comparison_01
		* comparison adjusting SPFs quantity and population
