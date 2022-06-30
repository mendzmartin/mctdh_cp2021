# ============================================================
# Especifico la regla que se ejuta por defecto
# ============================================================
#all: $(bin_name_01).o

# ============================================================
# COMPILERS
# ============================================================
# Fortran compiler
fcomp_01 = gfortran
# used fortran compiler
FC = $(fcomp_01)

# ============================================================
# COMPILER FLAGS
# ============================================================
# warning flags
flg_war01 = -Wall -Wextra -Wconversion -pedantic -ffpe-trap=overflow
# debugging flags
flg_deb01 = -ffpe-trap=zero -ffpe-trap=overflow -ffpe-trap=underflow 
flg_deb02 = -g -fcheck=all -fbacktrace -fbounds-check
# optimization flags
flg_opt01 = -o3 -ftree-vectorize -ftree-loop-vectorize
flg_opt02 = -march=native
# used compiler flags
FFLAGS = $(flg_opt01) $(flg_opt02) $(flg_war01) $(flg_deb01) $(flg_deb02)

# ============================================================
# USAR LIBRERIA LAPACK DE FORMA USUAL
# ============================================================
# library flags
flg_lib01 = -llapack -lrefblas
# library paths
lib_path01 = -L/nashome/mmendez/pruebas
# used library flags
#LDFLAGS = $(lib_path01) $(flg_lib01)

# ============================================================
# USAR LIBERÍA LAPACK MEDIAN MKL - BANDURRIA
# ============================================================
#EXTERNAL_BLAS = -fdefault-integer-8  -m64  -I${MKLROOT}/include
#EXTERNAL_LAPACK = -fdefault-integer-8  -m64  -I${MKLROOT}/include

EXTERNAL_BLAS = ${MKLROOT}/lib/intel64/libmkl_blas95_lp64.a
EXTERNAL_LAPACK = ${MKLROOT}/lib/intel64/libmkl_lapack95_lp64.a

MCTDH_ADD_LIBS = -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_gf_ilp64 -lmkl_gnu_thread -lmkl_core -lgomp -lpthread -lgfortran -lm -ldl
LDFLAGS = $(MCTDH_ADD_LIBS) $(EXTERNAL_LAPACK) $(EXTERNAL_BLAS)

# ============================================================
# BINARIES COMPILATION
# ============================================================
# binaries names
bin_name_01 = sinedvr_using_lapack

# object dependencies
dependencies_01= mmlib.o

# binaries rules
# sinedvr_using_lapack
$(bin_name_01).o: $(dependencies_01)
	$(FC) -o3 -march=native -fopenmp $(bin_name_01).f90 $(dependencies_01) $(LDFLAGS) -o $(bin_name_01).o

# ============================================================
# MODULES COMPILATION
# ============================================================
# modules paths
#mod_path = ./
# modules names
mod_name_01 = mmlib

# modules recipes
$(mod_name_01).o:
	$(FC) -c $(mod_path)$(mod_name_01).f
	
# ============================================================
# PONY rules
# ============================================================
clean:
	rm -f *.o *.mod

# References
# https://www.gnu.org/software/make/manual/make.html
# https://faculty.washington.edu/rjl/classes/am583s2013/notes/gfortran_flags.html
