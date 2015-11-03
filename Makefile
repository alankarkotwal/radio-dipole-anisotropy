all: main.f95 
	gfortran main.f95 -I/home/cheeku/SHTOOLS/modules/ -m64 -fPIC -O3 -ffast-math -L/home/cheeku/SHTOOLS/lib -lSHTOOLS -lfftw3 -lm -llapack -lblas -o test
