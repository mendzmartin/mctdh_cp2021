!----------------------------------------------------------
! Sine DVR TO APPROXIMATE HARMONIC OSCILLATOR (HO)
! Compilation comands
!----------------------------------------------------------
! 1) create out-data-folder: mkdir ../data_ho_study_04
! 2) compile subrutine: gfortran -c mmlib.f
! 3) compile program: gfortran sinedvr_ho_study_04.f90 mmlib.o -L/home/mendez/lapack-3.10.0 -llapack -lrefblas -o sinedvr_ho_study_04
! 4) run: ./sinedvr_ho_study_04

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
	real( 8 )					x, xi, xf, deltax, fac1
	real( 8 )					L, V
	!------------------------------------------------------
	! Hamiltonian variables
	!------------------------------------------------------
	real( 8 ) ::				m, position, omega
	!------------------------------------------------------
	! Discretitation L
	!------------------------------------------------------
	real( 8 ) ::				L_max, L_min, delta_L
	integer						L_max_integer, L_index
	!------------------------------------------------------
	! Number value of energies
	!------------------------------------------------------
	integer						number_values
	!------------------------------------------------------
	! LAPACK (Linear Algebra PACKage) variables
	!------------------------------------------------------
	integer						info,lwork
	real( 8 ), allocatable ::	work( : )
	
	!------------------------------------------------------
	! Reading & writing data from standard exite
	!------------------------------------------------------
	write( *, * ) 'Enter a maximum box width (L)'
	read( *, * ) L_max
	write( *, * ) 'Enter a minimum box width (L)'
	read( *, * ) L_min
	write( *, * ) 'Enter a spacing of grid (deltax)'
	read( *, * ) deltax
	write( *, * ) 'Enter a frequency value (omega)'
	read( *, * ) omega
	write( *, * ) 'How much energies do you want to show?'
	read( *, * ) number_values
	
	! Conditional to show errors
	if ( L_max < L_min ) then
		write( *, "( a, i4 )" ) "#### Error! The showed results are not correct. & 
		&You have inputted a Final beta value less than Initial beta value. ####"
	endif
	
	open( 20, file = '../data_ho_study_04/parameters.dat' )
	open( 30, file = '../data_ho_study_04/energies_e_vs_L.dat' )
	open( 40, file = '../data_ho_study_04/energies_o_vs_L.dat' )

	delta_L = 1.0d0
	
	L_max_integer = nint( ( L_max - L_min ) / delta_L )
	
	write( 20, * )	'number values of L = ', L_max_integer, 'L minimum = ', L_min, &
					'L maximum = ', L_max, 'deltax = ', deltax, 'omega = ', omega
	close( 20 )
	
	do L_index = 1, L_max_integer
		
		L = L_min + delta_L * ( L_index - 1 )
		
		!------------------------------------------------------
		! Grid parameters
		!------------------------------------------------------
		x = L / 2
		xi = -x
		xf = x
		
		gdim = nint( ( ( xf - xi ) / deltax ) + 1 )
		
		!------------------------------------------------------
		! Allocate memory
		!------------------------------------------------------
		allocate( trafo( gdim, gdim ), ort( gdim ), dif2mat( gdim, gdim ), &
		dif1mat( gdim, gdim ), workr( gdim, gdim ), H( gdim, gdim ) )
		allocate( aval( gdim ), diag( gdim ) )
		

		! Subroutine dsyev(JOBZ,UPLO,N,A,LDA,W,WORK,LWORK,INFO)
		call dsyev( 'V', 'L', gdim, H, gdim, aval, diag, -1, info )
		lwork = diag( 1 ) ! element 1 of diag( ) array
		allocate( work( lwork ) )
	
		call initsin( trafo, ort, dif2mat, dif1mat, gdim, xi, xf, workr)
			
		!--------------------------------------------------
		! Hamiltonian matrix
		!--------------------------------------------------
		m = 1.0d0 ! mass

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

			! Main diagonal 
			! Kinetic energy + poential energy
			H( g1,g1 ) = -0.5d0 * dif2mat( g1, g1 ) / m + V 
		enddo

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
		
		! eigenvals even (energy even) vs L
		write( 30, * ) L, aval( 1: number_values: 2)
		! eigenvals odd (energy odd) vs L
		write( 40, * ) L, aval( 2: number_values: 2 )
		
		deallocate( trafo, ort, dif2mat, dif1mat, workr, H )
		deallocate( aval, diag )
		deallocate( work )
		
    enddo

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
