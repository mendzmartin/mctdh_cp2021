C     Fede-----------------------------------------------------------------

C     -----------------------------------------
C     -Effective 2d potential for 2 electrons in harmonic confinement-
C     #################################################################
C     #### WARNING: m and w should be the same as in the op file ######
C     #################################################################
C     -----------------------------------------
C     INPUT:
C     z1,z2: longitudinal coordinates of 2 electrons in au 
C      OUTPUT:
C     v     : Coulomb potential energy in au

      subroutine eff2dcou(z1,z2,v)      

C     externally used variables
      real*8  z1,z2,v
C     internally used variables
      real*8  a,b,w,m,z,logv             

      m = 1.d0    ![a.u.], mass should be the same as in the op fil

      w = 1.0d0   ![a.u.]

      a = sqrt(m*w/2.d0)

      z = a*abs(z1-z2)

      b = acos(-1.d0)
      
      if ( z > 20.00 ) then ! after this the erf doesn't work
      v = 1.d0/abs(z1-z2)
      else
      logv= z**2 + log(erfc(z))      
      v = sqrt(b)*a*exp(logv)
      endif

      return
      end      

C     Fede-----------------------------------------------------------------


C--------------------------------------------------------------------------
C Place here your own potential energy routine (and remove the lines above).
C E.g.:
C     subroutine mysrf(r1,r2,theta,phi,v)
C        .... FORTRAN TEXT ..
C     return
C     end
C
C NOTE: You also have to modify the file source/opfuncs/usersrf.F
C       Subroutine uvpoint   and   subroutine usersurfinfo. 
C       Please edit the text accordingly.
C
C       You may name the coordinates as you like, but make sure that their 
C       ordering is appropriate. The variable v contains the energy value 
C       on return, i.e. v = V(r1,r2,theta,phi) 
C--------------------------------------------------------------------------

