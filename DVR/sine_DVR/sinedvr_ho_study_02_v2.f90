!----------------------------------------------------------
! Sine DVR TO APPROXIMATE HARMONIC OSCILLATOR (HO)
! Compilation comands
!----------------------------------------------------------
! 1) create out-data-folder: mkdir ../data_ho_study_02_v2
! 2) compile subrutine: gfortran -c mmlib.f
! 3) compile program: gfortran sinedvr_ho_study_02_v2.f90 mmlib.o -L/home/mendez/lapack-3.10.0 -llapack -lrefblas -o sinedvr_ho_study_02_v2
! 4) run: ./sinedvr_ho_study_02_v2

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
	real( 8 )					x, xi, xf, deltax, fac1
	real( 8 )					L, V, weight
	!------------------------------------------------------
	! Hamiltonian variables
	!------------------------------------------------------
	real( 8 ) ::				m, position, omega
	!------------------------------------------------------
	! LAPACK (Linear Algebra PACKage) variables
	!------------------------------------------------------
	integer						info,lwork
	real( 8 ), allocatable ::	work( : )
	!------------------------------------------------------
	! Variables for work to a range of number of grid points
	!------------------------------------------------------	
	integer						gdim_index, gdim_max, gdim_min
	!------------------------------------------------------
	! The processor time
	!------------------------------------------------------	
	real( 8 )					start_T1, end_T1, start_T2, end_T2, &
								start_T3, end_T3, &
								program_time, allocate_time
	!------------------------------------------------------
	! Reading & writing data from standard exite
	!------------------------------------------------------
	write( *, * ) 'Box Width (L)'
	read( *, * ) L
	write( *, * ) 'Maximum number of grid points (N)'
	read( *, * ) gdim_max
	write( *, * ) 'Minimum number of grid points (N)'
	read( *, * ) gdim_min
	write( *, * ) 'Frequency fixed value (omega)'
	read( *, * ) omega
	
	call cpu_time ( start_T1 )
	allocate_time = 0d0
	call cpu_time ( start_T2 )
	!------------------------------------------------------
	! Allocate memory (fixed size)
	!------------------------------------------------------
	allocate( trafo( gdim_max, gdim_max ), ort( gdim_max ), dif2mat( gdim_max, gdim_max ), &
	dif1mat( gdim_max, gdim_max ), workr( gdim_max, gdim_max ), H( gdim_max, gdim_max ) )
	allocate( aval( gdim_max ), diag( gdim_max ) )
	allocate( psi( gdim_max, gdim_max ) )
	call cpu_time ( end_T2 )
	allocate_time = allocate_time + ( end_T2 - start_T2 )

	! Subroutine dsyev(JOBZ,UPLO,N,A,LDA,W,WORK,LWORK,INFO)
	call dsyev( 'V', 'L', gdim_max, H, gdim_max, aval, diag, -1, info )
	lwork = diag( 1 ) ! element 1 of diag( ) array
	call cpu_time ( start_T3 )
	allocate( work( lwork ) )
	call cpu_time ( end_T3 )
	allocate_time = allocate_time + ( end_T3 - start_T3 )
	
	open( 30, file = '../data_ho_study_02_v2/eigenvals_e_vs_N.dat' )
	open( 40, file = '../data_ho_study_02_v2/eigenvals_o_vs_N.dat' )
	
	do gdim_index = gdim_min, gdim_max, 10
	
		gdim = gdim_index
		
		!------------------------------------------------------
		! Grid parameters
		!------------------------------------------------------
		x = L / 2
		xi = -x
		xf = x
		! dble(A) to Converts A to double precision real type.
		deltax = ( xf - xi ) / dble( gdim - 1 )
		
		! proportional factor to gate wave function
		weight = sqrt( 1 / deltax )
		
		call initsin( trafo( 1:gdim, 1:gdim ), ort( 1:gdim ), dif2mat( 1:gdim, 1:gdim ), &
		dif1mat( 1:gdim, 1:gdim ), gdim, xi, xf, workr( 1:gdim, 1:gdim ) )
		
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
		call dsyev( 'V', 'L', gdim, H( 1:gdim, 1:gdim ), gdim, aval( 1:gdim ), work, lwork, info )
		
		! Conditional to show errors
		if ( info /= 0 ) then
		
			write( 6, "( a, i4 )" ) "Error in DSYEV, INFO =", info
			
		endif
		
		! 100 eigenvals even (energy even) vs N 
		write( 30, * ) gdim, aval( 1: 10: 2 )
		! 100 eigenvals odd (energy odd) vs N
		write( 40, * ) gdim, aval( 2: 10: 2 )
		
    enddo
    
    
	close( 30 )
	close( 40 )
	
	call cpu_time( end_T1 )
	program_time = ( end_T1 - start_T1 )
	
	print *, 'Allocate time =', ( allocate_time * 0.001 ), '[ms]'
	print *, 'Program time =', ( program_time * 0.001 ), '[ms]'
	print *, 'Proportion of allocate time in relation to program time =', &
				( ( allocate_time * 100 ) / program_time ), '%'
    
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
! 2) https://gcc.gnu.org/onlinedocs/gfortran.pdf
