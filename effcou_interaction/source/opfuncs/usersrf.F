C#######################################################################
C    UDEFSRF    User-DEFinition-of-SuRFace  
C
C Multi-dimensional surfaces defined by the user.
C Do NOT put 1D functions here! Implement them on user1d.F .
C Compare with funcsrf.F
C
C ifile=203
C
C#######################################################################

      subroutine udefsrf(hopilab,label,ifile,pesopts,zpesopts,hopipar,
     +           hoprpar,maxhpar,pesmin,pesmax,lcutpes,ndof,ierr)

      implicit none
      
#include "global.inc"
#include "channels.inc"

      integer maxhpar,ndof,ilbl,jlbl,ll
      integer zpesopts(2*maxhpar,*)
      integer hopilab,ifile,ierr,hopipar(*)
      real*8  hoprpar(*),pesmin,pesmax 
      character*(*) label,pesopts(*)
      logical lcutpes
C--FMP------------------------------------------------------------------      
C     For rigid contact interaction      
      real*8 radio
C     For screened Coulomb interaction
      real*8 alpha,beta,masscoef

      integer nopt,np
C----------------------------------------------------------------------

  
      hopilab=0
      ifile=0  
      ierr=0

C-----------------------------------------------------------------------
C Determine label length
C-----------------------------------------------------------------------
         ilbl=index(label,'{')-1
         jlbl=index(label,' ')-1
         if(ilbl.le.0) ilbl=99
         if(jlbl.le.0) jlbl=99
         ll = min(ilbl,jlbl)
 
C-----------------------------------------------------------------------
C FOR EXAMPLES SEE defsrf AND surfinfo ON opfuncs/funcsrf.F 
C-----------------------------------------------------------------------

C Anni------------------------------------------------------------------

C-----------------------------------------------------------------------
C BEXP6DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'bexp6dcou') then
         hopilab=1
      endif

C-----------------------------------------------------------------------
C QUADR6DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'quadr6dcou') then
         hopilab=2
      endif

C-----------------------------------------------------------------------
C REGUL6DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'regul6dcou') then
         hopilab=3
      endif

C-----------------------------------------------------------------------
C REGUL4DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'regul4dcou') then
         hopilab=4
      endif

C-----------------------------------------------------------------------
C REGUL2DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'regul2dcou') then
         hopilab=5
      endif

C Anni------------------------------------------------------------------

C-----------------------------------------------------------------------
C BEXP2DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'bexp2dcou') then
         hopilab=6
      endif

C FMP------------------------------------------------------------------

C-----------------------------------------------------------------------
C EFF2DCOU surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'eff2dcou') then
         hopilab=7
      endif


C-----------------------------------------------------------------------
C ESFERA surface.
C-----------------------------------------------------------------------

      if (label(1:ll) .eq. 'esfera') then
         hopilab=8
      endif


C-----------------------------------------------------------------------
C INVSQUARE surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'invsquare') then
         hopilab=9
      endif

C-----------------------------------------------------------------------
C Rigid interaction surface.
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'rigid') then
         ilbl=index(label,'{')+1
         jlbl=index(label,'}')-1
         radio=0.d0
         if (ilbl .gt. 1) then
           read(label(ilbl:jlbl),*) np
           nopt=1
           ilbl=1
           jlbl=zpesopts(1,np)
  19       continue
           if (pesopts(np)(ilbl:jlbl) .eq. 'radio') then
             ilbl=zpesopts(nopt+1,np)+1
             jlbl=zpesopts(nopt+2,np)
             nopt=nopt+2
             read(pesopts(np)(ilbl:jlbl),*,iostat=ierr) radio
             if (ierr .ne.  0) then
                   routine='defsrf (opfuncs/usersrf.F)'
                   message='Cannot read argument "radio" of rigid'
                   go to 999
              endif
            else
              message='Unknown parameter for rigid: '
     +                  //pesopts(np)(ilbl:jlbl)
               routine='defsrf (opfuncs/usersrf.F, line 139)'
               call errormsg
            endif
            nopt=nopt+1
            ilbl=jlbl+1
            jlbl=zpesopts(nopt,np)
            if (jlbl .gt. 0) go to 19
          endif
         hoprpar(1)=radio
         hopilab=10
      endif

C-----------------------------------------------------------------------
C Screened Coulomb Interaction
C-----------------------------------------------------------------------
      if (label(1:ll) .eq. 'scou') then
         ilbl=index(label,'{')+1
         jlbl=index(label,'}')-1
         alpha=0.d0
         beta=0.d0
         masscoef=1.d0
         if (ilbl .gt. 1) then
           read(label(ilbl:jlbl),*) np
           nopt=1
           ilbl=1
           jlbl=zpesopts(1,np)
  21       continue
           if (pesopts(np)(ilbl:jlbl) .eq. 'alpha') then
             ilbl=zpesopts(nopt+1,np)+1
             jlbl=zpesopts(nopt+2,np)
             nopt=nopt+2
             read(pesopts(np)(ilbl:jlbl),*,iostat=ierr) alpha
             if (ierr .ne.  0) then
                   routine='defsrf (opfuncs/usersrf.F)'
                   message='Cannot read argument "alpha" of scou'
                   go to 999
              endif
            else if (pesopts(np)(ilbl:jlbl) .eq. 'beta') then
             ilbl=zpesopts(nopt+1,np)+1
             jlbl=zpesopts(nopt+2,np)
             nopt=nopt+2
             read(pesopts(np)(ilbl:jlbl),*,iostat=ierr) beta
             if (ierr .ne.  0) then
                   routine='defsrf (opfuncs/usersrf.F)'
                   message='Cannot read argument "beta" of scou'
                   go to 999
              endif
            else if (pesopts(np)(ilbl:jlbl) .eq. 'masscoef') then
             ilbl=zpesopts(nopt+1,np)+1
             jlbl=zpesopts(nopt+2,np)
             nopt=nopt+2
             read(pesopts(np)(ilbl:jlbl),*,iostat=ierr) masscoef
             if (ierr .ne.  0) then
                   routine='defsrf (opfuncs/usersrf.F)'
                   message='Cannot read argument "masscoef" of scou'
                   go to 999
              endif  
            else
              message='Unknown parameter for scou: '
     +                  //pesopts(np)(ilbl:jlbl)
               routine='defsrf (opfuncs/usersrf.F, line 177)'
               call errormsg
            endif
            nopt=nopt+1
            ilbl=jlbl+1
            jlbl=zpesopts(nopt,np)
            if (jlbl .gt. 0) go to 21
          endif
         hoprpar(1)=alpha
         hoprpar(2)=beta
         hoprpar(3)=masscoef
         hopilab=11
      endif


      
C--FMP------------------------------------------------------------------


C-----------------------------------------------------------------------
C if label is assigned, assign ifile number.
C-----------------------------------------------------------------------
      if (hopilab .ne. 0) ifile=203

      return

  999 continue
      routine='defsrf (opfuncs/funcsrf.F)'
      call errormsg
      return

      end


C##########################################################################
C    UVPOINT   User-V-POINT
C
C This routine calculates the value of a potential at a grid point.
C The point on the MCTDH grid is contained in gpoint. The modelabel
C flags allow a check so that gpoint(f) is passed as the correct degree
C of freedom to the potential calculation routine.
C
C To add new surfaces, add the new ifunc number, and then any code
C needed to manipulate the grid point and call the potential surface
C routine. Note that mysrf and DEF_mysrf already exist on source/surfaces, 
C the Fortran text of mysrf, however, has to be adapted to the needs.
C##########################################################################

C Anni------------------------------------------------------------------

      subroutine uvpoint (v,gpoint,ndof1,ifunc,hopipar,hoprpar)

      implicit none

#include "global.inc"

      integer ifunc,ndof1,hopipar(*)
      real*8  gpoint(ndof1),hoprpar(*)
      real*8  v, x1, x2, y1, y2, z1, z2,r,theta
      real*8  radio,alpha,beta,masscoef

      go to (1,2,3,4,5,6,7,8,9,10,11) ifunc

      routine='uvpoint (opfuncs/usersrf.F)'
      write(message,'(a,i5)') 'Surface not found :',ifunc
      call errormsg

   1  x1   =gpoint(1)
      y1   =gpoint(2)
      z1   =gpoint(3)
      x2   =gpoint(4)
      y2   =gpoint(5)
      z2   =gpoint(6)

      call bexp6dcou(x1,y1,z1,x2,y2,z2,v)
      return   ! Do not forget the RETURN statement.

   2  x1   =gpoint(1)
      y1   =gpoint(2)
      z1   =gpoint(3)
      x2   =gpoint(4)
      y2   =gpoint(5)
      z2   =gpoint(6)

      call quadr6dcou(x1,y1,z1,x2,y2,z2,v)
      return   ! Do not forget the RETURN statement.

   3  x1   =gpoint(1)
      y1   =gpoint(2)
      z1   =gpoint(3)
      x2   =gpoint(4)
      y2   =gpoint(5)
      z2   =gpoint(6)

      call regul6dcou(x1,y1,z1,x2,y2,z2,v)
      return   ! Do not forget the RETURN statement.

   4  x1   =gpoint(1)
      z1   =gpoint(2)
      x2   =gpoint(3)
      z2   =gpoint(4)

      call regul4dcou(x1,z1,x2,z2,v)
      return   ! Do not forget the RETURN statement.

   5  z1   =gpoint(1)
      z2   =gpoint(2)

      call regul2dcou(z1,z2,v)
      return   ! Do not forget the RETURN statement.

   6  z1   =gpoint(1)
      z2   =gpoint(2)

      call bexp2dcou(z1,z2,v)
      return   ! Do not forget the RETURN statement.
C FMP------------------------------------------------------------------

   7  z1   =gpoint(1)
      z2   =gpoint(2)

      call eff2dcou(z1,z2,v)
      return   ! Do not forget the RETURN statement.

   8  r   =gpoint(1)
      theta   =gpoint(2)

      call esfera(r,theta,v)
      return   ! Do not forget the RETURN statement.

   9  z1   =gpoint(1)
      z2   =gpoint(2)

      call invsquare(z1,z2,v)
      return   ! Do not forget the RETURN statement.

  10  z1   =gpoint(1)
      z2   =gpoint(2)
      radio =hoprpar(1)
      call rigid(z1,z2,radio,v)
      return   ! Do not forget the RETURN statement.

  11  x1   =gpoint(1)
      x2   =gpoint(2)
      alpha = hoprpar(1)
      beta  = hoprpar(2)
      masscoef = hoprpar(3)
      call scou(x1,x2,alpha,beta,masscoef,v)
      return   ! Do not forget the RETURN statement.

      end
C FMP------------------------------------------------------------------

C Anni------------------------------------------------------------------

C#######################################################################
C  User Surface Info. This routine is called from surfinfo.
C  Description of the user implemented surface and their coordinates.
C#######################################################################

C Anni------------------------------------------------------------------

      subroutine usersurfinfo(hopilab,hopipar,hoprpar,mlabel,nn,ilog)

      implicit none

#include "global.inc"

      integer   hopilab,ilog,nn,i,jj
      integer   hopipar(*)
      real*8    hoprpar(*)
      character*16 mlabel(*)

      goto(1,2,3,4,5,6,7,8,9,10,11) hopilab    ! Do not forget to update this goto.

      routine='usersurfinfo (opfuncs/usersrf.F)'
      write(message,'(a,i5)') 'Surface not found :', hopilab
      call errormsg

 1    write(ilog,'(a)')
     + 'bexp6dcou (6dim Coulomb potential).'
      write(ilog,'(a)') 'my_6DcouEE Coordinates, exp. regul. with b'
      write(ilog,'(2a)') 'x1    : ',mlabel(1)
      write(ilog,'(2a)') 'y1    : ',mlabel(2)
      write(ilog,'(2a)') 'z1    : ',mlabel(3)
      write(ilog,'(2a)') 'x2    : ',mlabel(4)
      write(ilog,'(2a)') 'y2    : ',mlabel(5)
      write(ilog,'(2a)') 'z2    : ',mlabel(6)
      jj=7   ! This is dimension+1
      goto 500

 2    write(ilog,'(a)')
     + 'quadr6dcou (6dim Coulomb potential).'
      write(ilog,'(a)') 'my_6DcouEE Coordinates, exp. regul. with b'
      write(ilog,'(2a)') 'x1    : ',mlabel(1)
      write(ilog,'(2a)') 'y1    : ',mlabel(2)
      write(ilog,'(2a)') 'z1    : ',mlabel(3)
      write(ilog,'(2a)') 'x2    : ',mlabel(4)
      write(ilog,'(2a)') 'y2    : ',mlabel(5)
      write(ilog,'(2a)') 'z2    : ',mlabel(6)
      jj=7   ! This is dimension+1
      goto 500

 3    write(ilog,'(a)')
     + 'regul6dcou (6dim Coulomb potential).'
      write(ilog,'(a)') 'my_6DcouEE Coordinates, exp. regul. with b'
      write(ilog,'(2a)') 'x1    : ',mlabel(1)
      write(ilog,'(2a)') 'y1    : ',mlabel(2)
      write(ilog,'(2a)') 'z1    : ',mlabel(3)
      write(ilog,'(2a)') 'x2    : ',mlabel(4)
      write(ilog,'(2a)') 'y2    : ',mlabel(5)
      write(ilog,'(2a)') 'z2    : ',mlabel(6)
      jj=7   ! This is dimension+1
      goto 500

 4    write(ilog,'(a)')
     + 'regul4dcou (4dim Coulomb potential).'
      write(ilog,'(a)') 'my_4DcouEE Coordinates, exp. regul. with b'
      write(ilog,'(2a)') 'x1    : ',mlabel(1)
      write(ilog,'(2a)') 'z1    : ',mlabel(2)
      write(ilog,'(2a)') 'x2    : ',mlabel(3)
      write(ilog,'(2a)') 'z2    : ',mlabel(4)
      jj=5   ! This is dimension+1
      goto 500

 5    write(ilog,'(a)')
     + 'regul2dcou (6dim Coulomb potential).'
      write(ilog,'(a)') 'my_6DcouEE Coordinates, exp. regul. with b'
      write(ilog,'(2a)') 'z1    : ',mlabel(1)
      write(ilog,'(2a)') 'z2    : ',mlabel(2)
      jj=3   ! This is dimension+1
      goto 500

 6    write(ilog,'(a)')
     + 'bexp2dcou (2dim Coulomb potential).'
      write(ilog,'(a)') 'my_2DcouEE Coordinates, exp. regul. with b'
      write(ilog,'(2a)') 'z1    : ',mlabel(1)
      write(ilog,'(2a)') 'z2    : ',mlabel(2)
      jj=3   ! This is dimension+1
      goto 500

C FMP------------------------------------------------------------------

 7    write(ilog,'(a)')
     + 'eff2dcou (2dim effective Coulomb potential).'
      write(ilog,'(a)') '#### WARNING ##### '
      write(ilog,'(a)') 
     +  'This potential depends is an effective zi i=1,2 coulomb pot.', 
     +  'integrated in xi,yi coord. It depends on the mass and the',
     +  'oscillator frequency ground state HO function used for xi,yi',
     +  'variables. CHECK consistency with your problem!'
      write(ilog,'(a)') '################## '
      write(ilog,'(a)') 'Eff. Coulomb Coordinates'
      write(ilog,'(2a)') 'z1    : ',mlabel(1)
      write(ilog,'(2a)') 'z2    : ',mlabel(2)
      jj=3   ! This is dimension+1
      goto 500

 8    write(ilog,'(a)')
     + 'esfera (Hard wall sphere displaced from coordinate origin).'
      write(ilog,'(a)') '#### WARNING ##### '
      write(ilog,'(a)')
     +  'This potential depends of R= sphere radius.',
     +  'and the sphere center R0'
      write(ilog,'(a)') '################## '
      write(ilog,'(a)') 'Coordinates'
      write(ilog,'(2a)') 'r        : ',mlabel(1)
      write(ilog,'(2a)') 'theta    : ',mlabel(2)
      jj=3   ! This is dimension+1
      goto 500

  9   write(ilog,'(a)')
     + 'invsquare '
      write(ilog,'(a)') 'inverse square Coordinates'
      write(ilog,'(2a)') 'z1    : ',mlabel(1)
      write(ilog,'(2a)') 'z2    : ',mlabel(2)
      jj=3   ! This is dimension+1
      goto 500

  10   write(ilog,'(a)')
     + 'rigid '
      write(ilog,'(a)') 'contact potential coordinates'
      write(ilog,'(2a)') 'z1    : ',mlabel(1)
      write(ilog,'(2a)') 'z2    : ',mlabel(2)
      write(ilog,'(a,f9.4)') 'radio : ',hoprpar(1) 
      jj=3   ! This is dimension+1
      goto 500
      
  11   write(ilog,'(a)')
     + 'scou '
      write(ilog,'(a)') 'Screened Coumlob interaction coordinates'
      write(ilog,'(2a)') 'x1    : ',mlabel(1)
      write(ilog,'(2a)') 'x2    : ',mlabel(2)
      write(ilog,'(a,f9.4)') 'alpha (exponential coef. Default = 0) : '
     +  ,hoprpar(1)
      write(ilog,'(a,f9.4)') 'beta (cut off Coulomb divergence coef. De
     + fault = 0) : ',hoprpar(2)
      write(ilog,'(a,f9.4)') 'masscoef (x2 multiplying coeff --> mu/m. 
     + Default = 1.0) : ',hoprpar(3)
      jj=3   ! This is dimension+1
      goto 500 
 

C FMP------------------------------------------------------------------

 500  do i =jj,nn
         write(ilog,'(2a)') 'Dummy Variable     : ',mlabel(i)
      enddo

      return
      end

C Anni------------------------------------------------------------------

C#######################################################################

