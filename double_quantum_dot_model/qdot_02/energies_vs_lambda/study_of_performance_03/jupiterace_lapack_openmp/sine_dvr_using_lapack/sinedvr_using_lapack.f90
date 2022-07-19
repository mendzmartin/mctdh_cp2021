!----------------------------------------------------------
! Sine DVR TO APPROXIMATE heff of double quantum dot model
! Compilation comands
!----------------------------------------------------------
! 1) create out-data-folder: mkdir result_sinedvr_using_lapack
! 2) compile subrutine: gfortran -c mmlib.f
! 3) compile program: gfortran sinedvr_using_lapack.f90 mmlib.o -L/home/mendez/lapack-3.10.0 -llapack -lrefblas -o sinedvr_using_lapack
! 4) run: ./sinedvr_using_lapack

! ó usando Makefile --> make clean && make sinedvr_using_lapack.o && ./sinedvr_using_lapack.o

program sindvr1d
	!------------------------------------------------------
	! No implicit variables declaration
	!------------------------------------------------------
    implicit none
	!------------------------------------------------------
	! Explicit variables declaration
	!------------------------------------------------------
    integer                :: g1,g2,gdim
    real(8), allocatable :: trafo(:,:),ort(:),dif2mat(:,:),&
                            dif1mat(:,:),workr(:,:),H(:,:)
    real(8), allocatable :: aval(:),diag(:)
    real(8), allocatable :: rho(:,:),psi(:,:)
    real(8)              :: x,xi,xf,deltax
    real(8)              :: L,V,weight
    integer              :: number_values
	!------------------------------------------------------
	! Hamiltonian variables
	!------------------------------------------------------
    real(8) :: position,V_left,V_right 
    real(8) :: depthVL,depthVR,sizebL,sizebR,R
	!------------------------------------------------------
	! Discretitation potential depth value of left qdot
	!------------------------------------------------------
    real(8) :: depthVL_max,delta_depthVL
    integer :: depthVL_max_integer,depthVL_integer
	!------------------------------------------------------
	! Writing multiple output files
	!------------------------------------------------------
    integer           :: index_file
    integer           :: number_file_even,number_file_odd
    character(len=70) :: filename_odd,filename_even
	!------------------------------------------------------
	! LAPACK (Linear Algebra PACKage) variables
	!------------------------------------------------------
    integer              :: info,lwork
    real(8), allocatable :: work(:)
        !------------------------------------------------------
        ! Variables to measure cpu time
        !------------------------------------------------------
    real(8) :: time_end,time_start

    call cpu_time(time_start)
	
	!------------------------------------------------------
	! Reading & writing data from standard exite
	!------------------------------------------------------
    ! write(*,*) 'Enter box width (L)';read(*,*) L
    ! write(*,*) 'Enter a number of grid points (N)';read(*,*) gdim
    ! write(*,*) 'Enter a maximum potential depth value of left qdot (V_L)';read(*,*) depthVL_max
    ! write(*,*) 'How much energies do you want to show?';read(*,*) number_values

    L=50.d0;gdim=1001;depthVL_max=1.1d0;number_values=50

	!------------------------------------------------------
	! Allocate memory
	!------------------------------------------------------
    allocate(trafo(gdim,gdim),ort(gdim),dif2mat(gdim,gdim),&
    dif1mat(gdim,gdim),workr(gdim,gdim),H(gdim,gdim))
    allocate(aval(gdim),diag(gdim))
    allocate(rho(gdim,gdim),psi(gdim,gdim))

	! Subroutine dsyev(JOBZ,UPLO,N,A,LDA,W,WORK,LWORK,INFO)
    call dsyev('V','L',gdim,H,gdim,aval,diag,-1,info)
    lwork=diag(1)   ! element 1 of diag( ) array
    allocate(work(lwork))

    open(10,file='result_sinedvr_using_lapack/eigenvals_even_vs_depthVL.dat')
    open(20,file='result_sinedvr_using_lapack/eigenvals_odd_vs_depthVL.dat')
	
	!------------------------------------------------------
	! Grid parameters
	!------------------------------------------------------
    x=L/2;xi=-x;xf=x
	! dble(A) to Converts A to double precision real type.
    deltax=(xf-xi)/dble(gdim-1)
    write(*,*) "deltax = ",deltax, "(Separation between grid points)"
      
	! proportional factor to gate wave function
    weight=sqrt(1/deltax)

    delta_depthVL=0.05d0
    depthVL_max_integer=nint(depthVL_max/delta_depthVL)
	
    do depthVL_integer=8,depthVL_max_integer
        depthVL=depthVL_integer*delta_depthVL

		!-------------------------------------------------------------------------------------------------
		! Writing multiple output files
		! secuency for create the wave functions for each value of depthVL
		!-------------------------------------------------------------------------------------------------
        index_file=depthVL_integer-8    ! index_file = { 0,1,2,... }
        number_file_even=100+index_file ! Warning ( 20 - 100 ) have to be less than ( depthVL_max_integer - depthVL_integer )
        number_file_odd=200+index_file  ! Warning ( 20 - 100 ) have to be less than ( depthVL_max_integer - depthVL_integer )
		
        write(filename_even,'("result_sinedvr_using_lapack/wave_function_even_",i0,".dat")') index_file
        write(filename_odd,'("result_sinedvr_using_lapack/wave_function_odd_",i0,".dat")') index_file

        open(number_file_even,file=filename_even)
        open(number_file_odd,file=filename_odd)
		
		!--------------------------------------------------
		! Grid points of sine DVR
		!--------------------------------------------------
        call initsin(trafo,ort,dif2mat,dif1mat,gdim,xi,xf,workr)
        open(1,file='result_sinedvr_using_lapack/dvrpoints.dat')
        do g1=1,gdim
            write(1,*) ort(g1)
        enddo
        close(1)
			
		!--------------------------------------------------
		! Hamiltonian matrix
		!--------------------------------------------------
        depthVR=0.6d0   ! potential depth of right qdot
        sizebL=0.22d0   ! parameterize the sizes of the left qdot
        sizebR=1.0d0    ! parameterize the sizes of the right qdot
        R=9.0d0         ! distance between centers of qdots
		
        open( 1, file = 'result_sinedvr_using_lapack/potential.dat' )
        do g1 = 1, gdim

            do g2 = 1, ( g1 - 1 )
                ! Off-diagonal
                ! Only kinetic energy
                H( g1, g2 ) = -0.5d0 * dif2mat( g1, g2 )
                H( g2, g1 ) = H( g1, g2 )
            enddo
            
            position = ort( g1 )
            
            ! Longitudinal open potential of qdots
            V_left = - depthVL * exp( - sizebL * ( position + R / 2 )**2 )
            V_right = - depthVR * exp( - sizebR * ( position - R / 2 )**2 )
            
            V = V_left + V_right
            write( 1, * ) ort( g1 ), V 

            ! Main diagonal 
            ! Kinetic energy + poential energy
            H( g1,g1 ) = -0.5d0 * dif2mat( g1, g1 ) + V 
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

        ! eigenvals even (energy even) vs potential depth value of left qdot
        write( 10, * ) depthVL, aval( 1: number_values: 2)
        ! eigenvals odd (energy odd) vs potential depth value of left qdot
        write( 20, * ) depthVL, aval( 2: number_values: 2 )

        do g2 = 1, gdim

            psi( g2, 1: number_values: 2 ) = weight * H( g2, 1: number_values: 2 ) ! wave function
            psi( g2, 2: number_values: 2 ) = weight * H( g2, 2: number_values: 2 ) ! wave function
            
            ! wave_function_even.dat and wave_function_odd.dat
            write( number_file_even, * ) ort( g2 ), psi( g2, 1: number_values: 2 )
            write( number_file_odd, * ) ort( g2 ), psi( g2, 2: number_values: 2 )
            
        enddo

        close( number_file_even )   ! wave_function_even.dat
        close( number_file_odd )    ! wave_function_odd.dat
	
    enddo
    
    close( 10 ) ! eigenvals_even_vs_depthVL.dat
    close( 20 ) ! eigenvals_odd_vs_depthVL.dat

    call cpu_time(time_end)
    write(*,*) 'elapsed time = ', time_end-time_start, '[s]'
      
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

    integer :: g1, g2, gdim
    real(8) :: trafo( gdim, gdim )
    real(8) :: ort( gdim ) 
    real(8) :: dif2mat( gdim, gdim ), dif1mat( gdim, gdim )
    real(8) :: workr( gdim, gdim )
    real(8) :: x, xi, xf, deltax
    real(8) :: fac1, fac2, pi

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

! 1)	LAPACK: Linear Algebra PACKage "subroutine dsyev"
!		link: http://www.netlib.org/lapack/explore-html/d2/d8a/group__double_s_yeigen_ga442c43fca5493590f8f26cf42fed4044.html#ga442c43fca5493590f8f26cf42fed4044
! 2)	Federico M Pont et al 2020 J. Phys.: Condens. Matter 32 065302
!		Predicting the performance of the inter-Coulombic electron capture from single-electron quantities
!		link: https://iopscience.iop.org/article/10.1088/1361-648X/ab41a9
! 3)	Writing multiple output files
!		link: https://stackoverflow.com/questions/6146516/writing-multiple-output-files-in-fortran
