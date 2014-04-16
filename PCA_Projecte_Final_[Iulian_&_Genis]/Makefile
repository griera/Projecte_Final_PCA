# Copyright (C) 1997-2000 Gidon Moont

# Biomolecular Modelling Laboratory
# Imperial Cancer Research Fund
# 44 Lincoln's Inn Fields
# London WC2A 3PX

# +44 (0)20 7269 3565
# http://www.bmm.icnet.uk/

#############

# This line you will definitely have to edit

FFTW_DIR        = $(HOME)/ProjecteFinalPCA/finalProject1213q2/sources/fftw-2.1.3/installation

#############

#############

# You may need/want to edit some of these
#
# Hint: For the CC_FLAGS have a look at what the fftw build used

SHELL                = /bin/sh

CC                   = gcc
MATH_FLAGS           = -mfpmath=sse -ffast-math -fno-math-errno

CC_DEFAULT_FLAGS     = -O3 -march=native -g -static
CC_OPROFILE_FLAGS    = -O3 -march=native -g -static ${MATH_FLAGS}
CC_GDB_FLAGS         = -march=native -g -static ${MATH_FLAGS}
CC_GPROF_FLAGS       = -O3 -march=native -g -pg -static ${MATH_FLAGS}
CC_OPT_FLAGS         = -O3 -march=native -static ${MATH_FLAGS}

STRIP                = strip

CC_LINKERS           = -lm

SECURITY	     = chmod 555

####################################################

# You should not be editing anything below here

CC_DEFAULT_FLAGS_FULL    = -I$(FFTW_DIR)/include $(CC_DEFAULT_FLAGS)
CC_OPROFILE_FLAGS_FULL   = -I$(FFTW_DIR)/include $(CC_OPROFILE_FLAGS)
CC_GDB_FLAGS_FULL        = -I$(FFTW_DIR)/include $(CC_GDB_FLAGS)
CC_GPROF_FLAGS_FULL	 = -I$(FFTW_DIR)/include $(CC_GPROF_FLAGS)
CC_OPT_FLAGS_FULL	 = -I$(FFTW_DIR)/include $(CC_OPT_FLAGS)

FFTW_LINKERS    = -L$(FFTW_DIR)/lib -lrfftw -lfftw

#############

# Select the proper gcc flags depending on CC_SELECT_FLAGS value specified at command line

ifeq (${CC_SELECT_FLAGS}, oprofile)
	override CC_SELECT_FLAGS = ${CC_OPROFILE_FLAGS}
	CC_SELECT_FLAGS_FULL = ${CC_OPROFILE_FLAGS_FULL}

else ifeq (${CC_SELECT_FLAGS}, gprof)
	override CC_SELECT_FLAGS = ${CC_GPROF_FLAGS}
	CC_SELECT_FLAGS_FULL = ${CC_GPROF_FLAGS_FULL}

else ifeq (${CC_SELECT_FLAGS}, gdb)
	override CC_SELECT_FLAGS = ${CC_GDB_FLAGS}
	CC_SELECT_FLAGS_FULL = ${CC_GDB_FLAGS_FULL}

else ifeq (${CC_SELECT_FLAGS}, opt)
	override CC_SELECT_FLAGS = ${CC_OPT_FLAGS}
	CC_SELECT_FLAGS_FULL = ${CC_OPT_FLAGS_FULL}

else	
	override CC_SELECT_FLAGS = ${CC_DEFAULT_FLAGS}
	CC_SELECT_FLAGS_FULL = ${CC_DEFAULT_FLAGS_FULL}
endif

#############

.SUFFIXES:	.c .o

.c.o:
		$(CC) $(CC_SELECT_FLAGS_FULL) -c $<

#############

LIBRARY_OBJECTS = manipulate_structures.o angles.o coordinates.o electrostatics.o grid.o qsort_scores.o

PROGRAMS = ftdock build randomspin

all:		$(PROGRAMS)

#############

ftdock:		ftdock.o $(LIBRARY_OBJECTS) structures.h
		$(CC) $(CC_SELECT_FLAGS_FULL) -o $@ ftdock.o $(LIBRARY_OBJECTS) $(FFTW_LINKERS) $(CC_LINKERS)
#		$(STRIP) $@
		$(SECURITY) $@

#############

build:		build.o $(LIBRARY_OBJECTS) structures.h
		$(CC) $(CC_SELECT_FLAGS) -o $@ build.o $(LIBRARY_OBJECTS) $(CC_LINKERS)
#		$(STRIP) $@
		$(SECURITY) $@

#############

randomspin:	randomspin.o $(LIBRARY_OBJECTS) structures.h
		$(CC) $(CC_SELECT_FLAGS) -o $@ randomspin.o $(LIBRARY_OBJECTS) $(CC_LINKERS)
#		$(STRIP) $@
		$(SECURITY) $@

#############

clean:
		rm -f *.o core $(PROGRAMS)

#############

# dependencies

ftdock.o:			structures.h
build.o:			structures.h
randomspin.o:			structures.h

angles.o:			structures.h
coordinates.o:			structures.h
electrostatics.o:		structures.h
grid.o:				structures.h
manipulate_structures.o:	structures.h
qsort_scores.o:			structures.h
