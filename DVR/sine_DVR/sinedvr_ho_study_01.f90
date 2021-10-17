!----------------------------------------------------------
! Sine DVR TO APPROXIMATE HARMONIC OSCILLATOR (HO)
! Compilation comands
!----------------------------------------------------------
! 1) create out-data-folder: mkdir ../data_ho_study_01
! 2) compile subrutine: gfortran -c mmlib.f
! 3) compile program: gfortran sinedvr_ho_study_01.f90 mmlib.o -L/home/mendez/lapack-3.10.0 -llapack -lrefblas -o sinedvr_ho_study_01
! 4) run: ./sinedvr_ho_study_01

program sindvr1d
	
	!------------------------------------------------------
	! No implicit variables declaration
	!------------------------------------------------------
	implicit none
	
	!------------------------------------------------------
	! Explicit variables declaration
	!------------------------------------------------------
	integer						g1, g2, gdim
	real( 8 ), allocatable ::	trafo( :, : ), ort( : ), dif2mat( :, : ), &
								dif1mat( :, : ), workr( :, : ), H( :, : )
	real( 8 ), allocatable ::	aval( : ), diag( : )
	real( 8 ), allocatable ::	psi( :, : )
	real( 8 )					x, xi, xf, deltax, fac1
	real( 8 )					L, V, weight
	!------------------------------------------------------
	! Hamiltonian variables
	!------------------------------------------------------
	real( 8 ) ::				m, position, omega
	!------------------------------------------------------
	! Discretitation omega
	!------------------------------------------------------
	real( 8 ) ::				omega_max, delta_omega
	integer						omega_max_integer, omega_integer
	!------------------------------------------------------
	! Exact value of energies
	!------------------------------------------------------
	real( 8 ), allocatable ::	exact_eigenvals( : )
	integer						n, number_values
	!------------------------------------------------------
	! LAPACK (Linear Algebra PACKage) variables
	!------------------------------------------------------
	integer						info,lwork
	real( 8 ), allocatable ::	work( : )
	
	!------------------------------------------------------
	! Reading & writing data from standard exite
	!------------------------------------------------------
	write( *, * ) 'Enter box width (L)'
	read( *, * ) L
	write( *, * ) 'Enter a number of grid points (N)'
	read( *, * ) gdim
	write( *, * ) 'Enter a maximum frequency value (omega)'
	read( *, * ) omega_max
	write( *, * ) 'How much energies do you want to show?'
	read( *, * ) number_values
	
	!------------------------------------------------------
	! Allocate memory
	!------------------------------------------------------
	allocate( trafo( gdim, gdim ), ort( gdim ), dif2mat( gdim, gdim ), &
	dif1mat( gdim, gdim ), workr( gdim, gdim ), H( gdim, gdim ) )
	allocate( aval( gdim ), diag( gdim ) )
	allocate( psi( gdim, gdim ) )
	

	! Subroutine dsyev(JOBZ,UPLO,N,A,LDA,W,WORK,LWORK,INFO)
	call dsyev( 'V', 'L', gdim, H, gdim, aval, diag, -1, info )
	lwork = diag( 1 ) ! element 1 of diag( ) array
	allocate( work( lwork ) )

	open( 10, file = '../data_ho_study_01/wave_function_e.dat' )
	open( 20, file = '../data_ho_study_01/wave_function_o.dat' )
	open( 30, file = '../data_ho_study_01/eigenvals_e_vs_omega.dat' )
	open( 40, file = '../data_ho_study_01/eigenvals_o_vs_omega.dat' )
	
	open( 31, file = '../data_ho_study_01/exact_eigenvals_e_vs_omega.dat' )
	open( 41, file = '../data_ho_study_01/exact_eigenvals_o_vs_omega.dat' )
	
	!------------------------------------------------------
	! Grid parameters
	!------------------------------------------------------
	x = L/2
	xi = -x
	xf = x
	! dble(A) to Converts A to double precision real type.
	deltax = ( xf - xi ) / dble( gdim - 1 )
	write( *, * ) "deltax = ", deltax, "(Separation between grid points)"
      
	! proportional factor to gate wave function
	weight = sqrt(1/deltax)

	delta_omega = 0.01d0
	omega_max_integer = nint( omega_max / delta_omega )
	
	allocate( exact_eigenvals( number_values * omega_max_integer ) )
	
	do omega_integer = 1, omega_max_integer
		
		omega = omega_integer * delta_omega
	
		call initsin( trafo, ort, dif2mat, dif1mat, gdim, xi, xf, workr)
		open( 1, file = '../data_ho_study_01/dvrpoints.dat' )
		do g1 = 1, gdim
			write( 1, * ) ort( g1 )
		enddo
		close( 1 )
			
		!--------------------------------------------------
		! Hamiltonian matrix
		!--------------------------------------------------
		m = 1.0d0 ! mass

		open( 1, file = '../data_ho_study_01/potential.dat' )
		do g1 = 1, gdim
		
			do g2 = 1, ( g1 - 1 )
				! Off-diagonal
				! Only kinetic energy
				H( g1, g2 ) = -0.5d0 * dif2mat( g1, g2 ) / m
				H( g2, g1 ) = H( g1, g2 )
			enddo
			
			position = ort( g1 )
			
			! Harmonic Oscilator Potential
			V = 0.5d0 * m * ( omega**2 ) * ( position**2 )
			write( 1, * ) ort( g1 ), V 

			! Main diagonal 
			! Kinetic energy + poential energy
			H( g1,g1 ) = -0.5d0 * dif2mat( g1, g1 ) / m + V 
		enddo
		close( 1 )

		! matrix initialization with ones
		aval = 1.d0
		diag = 1.d0
		
		!--------------------------------------------------
		!                    From LAPACK
		! Subroutine
		! dsyev(JOBZ,UPLO,N,A,LDA,W,WORK,LWORK,INFO)
		!--------------------------------------------------
		call dsyev( 'V', 'L', gdim, H, gdim, aval, work, lwork, info )
		
		! Conditional to show errors
		if ( info /= 0 ) then
			write( 6, "( a, i4 )" ) "Error in DSYEV, INFO =", info
		endif
		
		! eigenvals even (energy even) vs omega
		write( 30, * ) omega, aval( 1: number_values: 2)
		! eigenvals odd (energy odd) vs omega
		write( 40, * ) omega, aval( 2: number_values: 2 )
		
		do g2 = 1, gdim
		
			psi( g2, 1: number_values: 2 ) = abs( weight * H( g2, 1: number_values: 2 ) )**2 ! rho!!!!!
			psi( g2, 2: number_values: 2 ) = abs( weight * H( g2, 2: number_values: 2 ) )**2
			
			! wave_function even and wave_function odd
			write( 10, * ) ort( g2 ), psi( g2, 1: number_values: 2 )
			write( 20, * ) ort( g2 ), psi( g2, 2: number_values: 2 )
			
		enddo
    
		do n = 1, number_values, 2
			exact_eigenvals( n ) = ( ( n - 1 ) + 0.5d0 ) * omega
		enddo
		do n = 2, number_values, 2
			exact_eigenvals( n ) = ( ( n - 1 ) + 0.5d0 ) * omega
		enddo
		
		write( 31, * ) omega, exact_eigenvals( 1: number_values: 2 )
		write( 41, * ) omega, exact_eigenvals( 2: number_values: 2 )
		
    enddo
    
	close( 10 )
	close( 20 )
	close( 30 )
	close( 40 )
	close( 31 )
	close( 41 )
      
endprogram sindvr1d

!-----------------------------------------------------------------------
! 
!                Module INIT1
!
! Contents: initho, initrho, initsin, initexp, initfft, initcos,
!           initsphfbr, initlagu 
!
! calls lapack-routine DSTEQR to diagonalise tri-diagonal matrices.
!
! Initialises the arrays trafo, dif2mat and dif1mat for a DVR basis set
!
! variables passed:
!  trafo   : DVR/FBR transformation matrices 
!  ort     : DVR grid points
!  dif1mat : DVR first  derivative matrix
!  dif2mat : DVR second derivative matrix
!  gdim    : number of DVR grid points for this mode
!  xi      : Value of first DVR grid point
!  xf      : Value of last  DVR grid point
!  hofm    : mass * vibrational frequency (homass*hofreq)
!  hoxeq   : equilibrium position of oscillator 
!  workr   : work array 
!
!
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!                Subroutine INITSIN
!                   Sine DVR
!-----------------------------------------------------------------------

subroutine initsin( trafo, ort, dif2mat, dif1mat, gdim, xi, xf, workr)

	implicit none

	integer		g1, g2, gdim
	real( 8 )	trafo( gdim, gdim )
	real( 8 )	ort( gdim ) 
	real( 8 )	dif2mat( gdim, gdim ), dif1mat( gdim, gdim )
	real( 8 )	workr( gdim, gdim )
	real( 8 )	x, xi, xf, deltax
	real( 8 )	fac1, fac2, pi

	deltax = ( xf - xi ) / dble( gdim - 1 )

	! Grid points are analytically given
	do g1 = 1, gdim
		ort( g1 ) = xi + ( g1 - 1 ) * deltax ! ( x_0 + alpha * deltax )
	enddo         

	pi = 4.d0 * atan( 1.d0 )
	x = gdim + 1.d0 ! ( N + 1 )
	fac1 = pi / x
	
	! DVR/FBR transformation matrix is analytically given
	do g1 = 1, gdim
		do g2 = 1, gdim
			trafo( g2, g1 ) = sqrt( 2d0 / x ) * sin( g2 * g1 * fac1 )
		enddo
	enddo

	! Second derivative in Sine-DVR basis (given analytically)
	do g1 = 1, gdim
		do g2 = 1, ( g1 - 1 )
			dif2mat( g2, g1 ) = -( pi / deltax )**2 &
				* 2d0 * ( -1d0 )**( g2 - g1 ) / x**2 &
				* sin( g2 * fac1 ) * sin( g1 * fac1 ) &
				/ ( cos( g2 * fac1 ) - cos( g1 * fac1 ) )**2
            dif2mat( g1, g2 ) = dif2mat( g2, g1 )
		enddo
		dif2mat( g1, g1 ) = -( pi / deltax )**2 &
			* ( 1d0 / 3d0 + 1d0 / ( 6d0 * x**2 ) &
			- 1d0 / ( 2d0 * x**2 * sin( g1 * fac1 )**2 ) )
	enddo        
         
	fac2 = 4.d0 / ( ( gdim + 1 ) * deltax ) ! 4 / L
	
	! First derivative in Sine-DVR basis
	do g1 = 1, gdim
		do g2 = 1, ( g1 - 1 )
			if ( mod( g2 - g1, 2 ) == 0 ) then
				! Main diagonal
				dif1mat( g2, g1 ) = 0.d0
			else
				! Off-diagonal
				dif1mat( g2, g1 ) = fac2 * g2 * g1 / ( g2**2 - g1**2 )
			endif
			! Off-diagonal
			dif1mat( g1, g2 ) = -dif1mat( g2, g1 )
		enddo
		! Main diagonal
		dif1mat( g1, g1 ) = 0.d0 
	enddo

!-----------------------------------------------------------------------
! Transform first derivative matrix from FBR to DVR form.
!-----------------------------------------------------------------------
	! subroutines in mmlib.f
	call qqxxdd( dif1mat, trafo, workr, gdim )
	call qqtxdd( trafo, workr, dif1mat, gdim )

	return
end subroutine initsin

!-----------------------------------------------------------------------
! References.
!-----------------------------------------------------------------------

! 1) http://www.netlib.org/lapack/explore-html/d2/d8a/group__double_s_yeigen_ga442c43fca5493590f8f26cf42fed4044.html#ga442c43fca5493590f8f26cf42fed4044
! 2) 
