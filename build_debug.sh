cd build 
 
gfortran -O0 -g -Wall -Wextra -cpp -fbounds-check -fimplicit-none -ffpe-trap=invalid -pedantic -ffree-line-length-0 -DDEBUG -o ../CSys.xx -I../include ../src/ModuleGlobalMem.f90 ../src/ModuleCO2.F90 ../src/ModuleConstants.f90 ../src/ModuleParam.F90 ../src/mem.F90 ../src/CarbonateSystem.F90 ../src/Main.F90
