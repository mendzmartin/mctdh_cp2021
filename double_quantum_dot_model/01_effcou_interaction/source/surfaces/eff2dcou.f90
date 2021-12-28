!----------------------------------------------------------
! Federico Manuel Pont (FMP)
!----------------------------------------------------------

!----------------------------------------------------------
! Effective 2d potential for 2 electrons in harmonic confinement
!----------------------------------------------------------
! WARNING: m and w should be the same as in the op file
!----------------------------------------------------------

!----------------------------------------------------------
! INPUT:
!  z1,z2: longitudinal coordinates of 2 electrons in au 
! OUTPUT:
!  v: Coulomb potential energy in au
!----------------------------------------------------------

subroutine eff2dcou(z1,z2,v)      

	! externally used variables
	real*8  z1,z2,v
	! internally used variables
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

end subroutine eff2dcou

!----------------------------------------------------------
! Federico Manuel Pont (FMP)
!----------------------------------------------------------


!----------------------------------------------------------
! Place here your own potential energy routine (and remove the lines above).
! E.g.:
!     subroutine mysrf(r1,r2,theta,phi,v)
!        .... FORTRAN TEXT ..
!     return
!     end
!
! NOTE: You also have to modify the file source/opfuncs/usersrf.F
!       Subroutine uvpoint   and   subroutine usersurfinfo. 
!       Please edit the text accordingly.
!
!       You may name the coordinates as you like, but make sure that their 
!       ordering is appropriate. The variable v contains the energy value 
!       on return, i.e. v = V(r1,r2,theta,phi) 
!----------------------------------------------------------

