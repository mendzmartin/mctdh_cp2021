!----------------------------------------------------------
! Sine DVR TO APPROXIMATE HARMONIC OSCILLATOR (HO)
! Compilation comands
!----------------------------------------------------------
! 1) create out-data-folder: mkdir ../data_ho
! 2) compile subrutine: gfortran -c mmlib.f
! 3) compile program: gfortran sinedvr_ho.f90 mmlib.o -L/home/mendez/lapack-3.10.0 -llapack -lrefblas -o sinedvr_ho
! 4) run: ./sinedvr_ho

program sindvr1d
	! use autov_real8
	
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
	real( 8 )					beta_start, beta_end
	integer						n_beta, n_beta_max
	real( 8 )					x, xi, xf, deltax, fac1
	real( 8 )					L, V, weight
	!------------------------------------------------------
	! Hamiltonian variables
	!------------------------------------------------------
	real( 8 ) ::				m, beta, delta_beta
	real( 8 ) ::				position, omega
	!------------------------------------------------------
	! LAPACK (Linear Algebra PACKage) variables
	!------------------------------------------------------
	integer						info,lwork
	real( 8 ), allocatable ::	work( : )
	
	!------------------------------------------------------
	! Reading & writing data from standard exite
	!------------------------------------------------------
	write( *, * ) 'Total grid size'
	read( *, * ) x
	write( *, * ) 'Number of grid points'
	read( *, * ) gdim
	write( *, * ) 'Frequency value'
	read( *, * ) omega
	write( *, * ) 'Initial beta value'
	read( *, * ) beta_start
	write( *, * ) 'Final beta value'
	read( *, * ) beta_end

	! Conditional to show errors
	if ( beta_end < beta_start ) then
		write( *, "( a, i4 )" ) "#### Error! The showed results are not correct. & 
		&You have inputted a Final beta value less than Initial beta value. ####"
	endif
	
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

	open( 10, file = '../data_ho/eigenvect_e.dat' )
	open( 11, file = '../data_ho/wave_function_o.dat' )
	open( 20, file = '../data_ho/eigenvect_o.dat' )
	open( 21, file = '../data_ho/wave_function_e.dat' )
	open( 30, file = '../data_ho/eigenvals_e_vs_beta.dat' )
	open( 40, file = '../data_ho/eigenvals_o_vs_beta.dat' )
	
	!------------------------------------------------------
	! Grid parameters
	!------------------------------------------------------
	xi = -x
	xf = x
	! dble(A) to Converts A to double precision real type.
	deltax = 2 * ( xf - xi ) / dble( gdim - 1 )
	L = ( xf - xi) ! box width 
	write( *, * ) "deltax = ", deltax, "(Separation between grid points)"
	write( *, * ) "L = ", L, "(Box Width)"
	write( *, * ) "N = ", gdim, "(Number of grid points)"
	
	! e.g.: 1.0d0 is a double precision real
	delta_beta = 0.01d0
	! nint: rounds its argument to the nearest integer number
	n_beta_max = nint( ( beta_end - beta_start ) / delta_beta ) + 1
      
	! proportional factor to gate wave function
	weight = sqrt(1/deltax)
	
	do n_beta = 1, n_beta_max
		beta = ( n_beta - 1 ) * delta_beta + beta_start

		call initsin( trafo, ort, dif2mat, dif1mat, gdim, xi, xf, workr)
		open( 1, file = '../data_ho/dvrpoints.dat' )
		do g1 = 1, gdim
			write( 1, * ) ort( g1 )
		enddo
		close( 1 )

		!--------------------------------------------------
		! Hamiltonian matrix
		!--------------------------------------------------
		m = 1.0d0 ! mass

		open( 1, file = '../data_ho/potential.dat' )
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

		write( 30, * ) beta, aval( 1: 100: 2 )
		write( 40, * ) beta, aval( 2: 100: 2 )
		
		
		do g2 = 1, gdim
		
			psi( g2, 1: 11: 2 ) = abs( weight * H( g2, 1: 11: 2 ) )**2
			psi( g2, 2: 10: 2 ) = abs( weight * H( g2, 2: 10: 2 ) )**2
			
			! eigenvect_e and eigenvect_o
			write( 10, * ) ort( g2 ), H( g2, 1: 11: 2 )
			write( 20, * ) ort( g2 ), H( g2, 2: 10: 2 )
			
			! wave_function_e and wave_function_o
			write( 11, * ) ort( g2 ), psi( g2, 1: 11: 2 )
			write( 21, * ) ort( g2 ), psi( g2, 2: 10: 2 )
			
		enddo        
        
	enddo !sizegrid
      

	close( 10 )
	close( 11 )
	close( 20 )
	close( 21 )
	close( 30 )
	close( 40 )
      
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
