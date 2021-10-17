! Sine DVR TO APPROXIMATE NeHe+ NANO-THREAD POTENTIAL 
! create out-data-folder: mkdir ../data_sinedvr_NeHeplus
! compile: gfortran sinedvr_1e1N_vs_beta.f mmlib.o -L/home/mendez/lapack-3.10.0 -llapack -lrefblas -o sinedvr_NeHeplus
! run: ./sinedvr_NeHeplus

      program sindvr1d
!       use autov_real8
      implicit none
      
      integer             g1,g2,gdim,ipar
      real(8),allocatable :: trafo(:,:),ort(:),dif2mat(:,:)
     + ,dif1mat(:,:),workr(:,:),H(:,:)
      real(8),allocatable :: aval(:),diag(:)
      real(8),allocatable :: auxv(:,:),auxv2(:,:),auxa(:)
      integer             nmin(1)
      real(8)             Betaini,Betafin ,L
      INTEGER             nBeta,nBetamax,i
      real(8)             theta
      real(8)             x,xi,xf,deltax,fac1,Pi
      real(8)             bl,br,vr,vl,V,am,norm
!#####Hamiltonian Parameters#############################
      real(8)		:: m,alpha,beta,deltaBeta
      real(8)		:: alphaAe,betaAe
      real(8)		:: mA,mB,mu,Z
!########################################################
      real(8)		:: distAsqr


!## LAPACK ##############################################
      integer             info,lwork
      REAL(8),ALLOCATABLE :: work(:)
!####################################################################
!####RHO#############################################################
      real(8)             rho,rhopar,rhoimpar
      real(8)             de,depar,deimpar
      real(8)             erho,erhopar,erhoimpar
!####################################################################
      write(*,*) 'total grid size'
      read(*,*) x
      write(*,*) 'Number of grid points'
      read(*,*) gdim
      write(*,*) 'initial beta value'
      read(*,*) Betaini
      write(*,*) 'final beta value'
      read(*,*) Betafin
      
     


      allocate(trafo(gdim,gdim),ort(gdim),dif2mat(gdim,gdim), 
     +  dif1mat(gdim,gdim),workr(gdim,gdim),H(gdim,gdim))
      allocate(aval(gdim),diag(gdim))
      allocate(auxv(gdim,gdim),auxv2(gdim,gdim),auxa(gdim))

      CALL DSYEV('V','L',gdim,H,gdim,aval,diag,-1,info)
      lwork=diag(1)
      ALLOCATE(work(lwork))

      open(10,file='../sinedvr_NeHeplus/eigenvals_e_vs_beta.dat')
      open(11,file='../sinedvr_NeHeplus/eigenvals_o_vs_beta.dat')
      open(8,file='../sinedvr_NeHeplus/eigenvect_e_vs_beta.dat')
      open(9,file='../sinedvr_NeHeplus/eigenvect_o_vs_beta.dat')
! ### Grid parameters################################################
        xi=-x
        xf=x
        deltax = 2*(xf-xi)/dble(gdim-1)
      write(*,*) "deltax: ", deltax
! ###################################################################
      deltaBeta=0.01d0
      nBetamax=nint((Betafin-Betaini)/deltaBeta) + 1
      
      DO nBeta=1,nBetamax
        Beta = (nBeta-1)*deltaBeta + Betaini
        ipar=0
      
        CALL initsin(trafo,ort,dif2mat,dif1mat,gdim,xi,xf, 
     +       workr,ipar)
        OPEN(1,file='../sinedvr_NeHeplus/dvrpoints.dat')
        DO g1=1,gdim
           write(1,*) ort(g1)
        enddo
        close(1)

! ### potential and hamiltonian parameters###########################
        m=1.0d0
!         alpha=0.d0
        !beta=0.36d0
        !alpha=1.02d0 ! for Ne
        !alpha=1.39d0 ! for He
        !alpha=0.08d0 ! for He, to achieve Ne+ -He bond length.
        !alpha=0.125d0 ! for Ne, to achieve Ne+ -He bond length.
        alpha=1.d0/(2.d0*(7.d0)**2)
        alphaAe=alpha
        betaAe=beta
        !mp=1836.152673d0
        !m_alpha=7294.29954142d0
        !m_neon=19.9924401754d0*1822.888486209d0
        mA=7294.29954142d0
         mu=mA*m/(mA+m)
         Z=1.0d0
! ###################################################################


! ###################################################################
        open(1,file='../sinedvr_NeHeplus/potential.dat')
        do g1=1,gdim
           do g2=1,g1-1
              H(g1,g2) = -0.5d0*dif2mat(g1,g2)/mu
              H(g2,g1) = H(g1,g2)
           enddo
! Potential ####################################################
        distAsqr=ort(g1)**2
        V= -Z*exp(-alphaAe*distAsqr)/sqrt(distAsqr+betaAe) 
        !V=-Z/sqrt(distAsqr+betaAe) + 
!      +   (Z-1.d0)*(1-exp(-alphaAe*distAsqr))/sqrt(distAsqr+betaAe)
            write(1,*) ort(g1),V 
! ##############################################################
           H(g1,g1) = -0.5d0*dif2mat(g1,g1)/mu + V 
         enddo
         close(1)
! ###################################################################

         aval=1.d0
         diag=1.d0
! ## From LAPACK################################################
!        CALL DSYEV('V','L',gdim,H,gdim,aval,diag,-1,info)
!        lwork=diag(1)
!        ALLOCATE(work(lwork))
        CALL DSYEV('V','L',gdim,H,gdim,aval,work,lwork,info)
        IF (INFO.NE.0) THEN
           WRITE(6,"(a,i4)") "Error in DSYEV, INFO =", info
        ENDIF
! ###################################################################

         pi=4.d0*atan(1.d0)
         WRITE(10,*) beta,aval(1:100:2)
         WRITE(11,*) beta,aval(2:100:2)
         
!          OPEN(12, file="rho.dat")
!          OPEN(13, file="rhopar.dat")
!          OPEN(14, file="rhoimpar.dat")
!           OPEN(15, file="eigvals.dat")
!          
!           DO i=1,gdim-1
!              WRITE(15,*) i,aval(i)
!             if (aval(i)>0.d0) then
!                 erho=(aval(i)+aval(i+1))/2
!                 de=(aval(i+1)-aval(i))
!                 rho=1.d0/L/de
!                 if (mod(i,2)==0) then
!                     erhopar=(aval(i)+aval(i+2))/2
!                     depar=(-aval(i)+aval(i+2))
!                     rhopar=2.d0/L/depar
!                  WRITE(12,*) erho,rho,1.d0/pi/sqrt(2.d0*erho)
!                  WRITE(13,*) erhopar,rhopar,
!      +          1.d0/pi/sqrt(2.d0*erhopar)
!                 else
!                     erhoimpar=(aval(i+1)+aval(i+3))/2
!                     deimpar=(-aval(i+1)+aval(i+3))
!                     rhoimpar=2.d0/L/deimpar
!                  WRITE(12,*) erho,rho,1.d0/pi/sqrt(2.d0*erho)
!                  WRITE(14,*) erhoimpar,rhoimpar,
!      +          1.d0/pi/sqrt(2.d0*erhoimpar)
!                 endif
!             endif
!           ENDDO
!          CLOSE(12)
!          CLOSE(13)
!          CLOSE(14)
!            CLOSE(15)
         DO g2=1,gdim
           WRITE(8,*) ort(g2), H(g2,1:11:2)
           WRITE(9,*) ort(g2), H(g2,2:10:2)
         ENDDO        
        
      ENDDO !sizegrid
      
      
      CLOSE(10)
      CLOSE(11)
      CLOSE(8)
      CLOSE(9)
      
      ENDPROGRAM

      function theta(x)
      implicit none
      real(8)             :: theta
      real(8), intent(in) :: x

      if (x>0) then
        theta=1.d0
      else
        theta=0.d0
      endif
      return 
      endfunction theta

!***********************************************************************
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
!***********************************************************************
!#######################################################################


!-----------------------------------------------------------------------
!                Subroutine INITSIN
!                   Sine DVR
!-----------------------------------------------------------------------

      subroutine initsin(trafo,ort,dif2mat,dif1mat,gdim,xi,xf,
     +                   workr,ipar)

      implicit none

      integer g1,g2,gdim,ipar
      real*8 trafo(gdim,gdim),ort(gdim),dif2mat(gdim,gdim)
     +     ,dif1mat(gdim,gdim),workr(gdim,gdim),
     +     x,xi,xf,deltax,fac1,Pi

      Pi     = 4.d0*atan(1.d0)
      deltax = (xf-xi)/dble(gdim-1)
      x      = gdim+1.d0
      fac1   = Pi/x

! --- Grid points are analytically given

      do g1=1,gdim
         ort(g1)=xi+(g1-1)*deltax
      enddo         

! --- DVR/FBR transformation matrix is analytically given

      do g1=1,gdim
         do g2=1,gdim
            trafo(g2,g1)= sqrt(2d0/x)*sin(g2*g1*fac1)
         enddo
      enddo

! --- Second derivative in Sine-DVR basis (given analytically)

      do g1=1,gdim
         do g2=1,g1-1
            dif2mat(g2,g1)=-(Pi/deltax)**2
     +           *2d0*(-1d0)**(g2-g1)/x**2
     +           *sin(g2*fac1)*sin(g1*fac1)
     +           /(cos(g2*fac1)-cos(g1*fac1))**2
            dif2mat(g1,g2)=dif2mat(g2,g1)
         enddo
         dif2mat(g1,g1)=-(Pi/deltax)**2
     +        *(1d0/3d0+1d0/(6d0*x**2)
     +        -1d0/(2d0*x**2*sin(g1*fac1)**2))
      enddo        

!-----------------------------------------------------------------------
! Derivative in FBR basis is analytically given for SIN-DVR
! but is not tridiagonal:
!   i)  all diagonal elements and all elements for which the row
!       and the column index are simultaneously odd or even
!       are zero
!   ii) for all other elements it holds:
!
!           d_ab = 4ab/(a**2-b**2) 1/(gdim+1) 1/deltax
!
!   iii) from ii) it follows that the matrix is still antisymmetric
!-----------------------------------------------------------------------
         
      if(ipar .eq. 0) then
         fac1 = 4.d0/((gdim+1)*deltax)
         do g1=1,gdim 
            do g2=1,g1-1
               if (mod(g2+g1,2).eq.0) then
                  dif1mat(g2,g1) = 0.d0
               else
                  dif1mat(g2,g1) = fac1*g2*g1/(g2**2-g1**2)
               endif
               dif1mat(g1,g2) = -dif1mat(g2,g1)
            enddo
            dif1mat(g1,g1) = 0.d0 
         enddo

!-----------------------------------------------------------------------
! Calculate DVR matrix representation of of 0.5*(sin*d/dq + d/dq*sin)
!-----------------------------------------------------------------------
      elseif(ipar .eq. 1) then            !  "sdq"
!         call zeromxd(dif1mat,gdim,gdim)
!         fac1 = 0.25d0*(Pi/((gdim+1)*deltax))  
!         do g1=1,gdim-1
!            dif1mat(g1,g1+1) = -fac1*(2*g1+1)
!            dif1mat(g1+1,g1) =  fac1*(2*g1+1)
!         enddo
      
! --- use special spin form, or transform from FBR to DVR basis
      elseif(ipar .eq. 2) then            !  "spin"
         dif1mat(1,1) = 0.d0
         dif1mat(1,2) =-0.5d0
         dif1mat(2,1) = 0.5d0
         dif1mat(2,2) = 0.d0
         dif2mat(1,1) = 0.d0
         dif2mat(1,2) = 0.5d0
         dif2mat(2,1) = 0.5d0
         dif2mat(2,2) = 0.d0
         return
      endif

!-----------------------------------------------------------------------
! Transform first derivative matrix from FBR to DVR form.
!-----------------------------------------------------------------------
      call qqxxdd(dif1mat,trafo,workr,gdim)
      call qqtxdd(trafo,workr,dif1mat,gdim)

      return
      end



!#######################################################################



