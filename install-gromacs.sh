#! /bin/bash

### The following was used to install on local machine:

source /etc/profile.d/modules.sh

## module purge
## module load intel/16.0
## module load gcc/4.8.2
## module load openmpi/1.8.5/intel/any
## module load cudatoolkit/8.0
# module load fftw/3.3.4
# module load Cmake
# module load Fftw/3.3.4

module purge
module load cmake/3.7.2
module load intel/18.0
module load gcc/.5.4.0
module load openmpi/1.8.5/intel/any 
module load cudatoolkit/8.0 # hacked version from /u/sbp/bussi/modules

export CMAKE_PREFIX_PATH=/u/sbp/programs/64/Fftw/3.3.4

#installdir=/u/sbp/bussi/modules/Gromacs5.0.4c/sse
#installdir=/u/sbp/bussi/modules/Gromacs2016.5
installdir=/u/sbp/bussi/modules/2018/Gromacs2016.5
installdir=/u/sbp/bussi/modules/2018/Gromacs2018.4
umask 022

mkdir build-sp
cd build-sp

cmake .. \
    -DCMAKE_C_COMPILER:FILEPATH=$(which mpicc) \
    -DCMAKE_CXX_COMPILER:FILEPATH=$(which mpic++) \
    -DCMAKE_INSTALL_PREFIX:STRING=$installdir \
    -DGMX_MPI=ON

make -j 18

make install
cd ../

mkdir build-dp
cd build-dp

cmake .. \
    -DCMAKE_C_COMPILER=$(which mpicc) \
    -DCMAKE_CXX_COMPILER:FILEPATH=$(which mpic++) \
    -DCMAKE_INSTALL_PREFIX:STRING=$installdir \
    -DGMX_DOUBLE:BOOL=ON \
    -DGMX_GPU:BOOL=OFF \
    -DGMX_MPI:BOOL=ON 

make -j 12 
make install



### This was used to install on frontend2 WITH PLUMED:

source /etc/profile.d/modules.sh

module purge
module load cmake/3.5.0

# mbernett: this is to be consistent with the modules used to compile plumed 2.5s
module load openmpi/1.8.3/intel/17.0
# the above line implies automatically loading also:
# module load intel/18.4
# module load gnu/4.9.2

module load cudatoolkit/10.0
export CMAKE_PREFIX_PATH=/home/bussi/modules/fftw/3.3.4/intel

installdir=/home/mbernett/modules/GROMACS/gromacs-2018.4
umask 022

mkdir build-sp
cd build-sp

cmake .. \
    -DCMAKE_C_COMPILER:FILEPATH=$(which mpicc) \
    -DCMAKE_CXX_COMPILER:FILEPATH=$(which mpic++) \
    -DCMAKE_INSTALL_PREFIX:STRING=$installdir \
    -DGMX_MPI=ON

make -j 8

make install
cd ../


### This was used to install on frontend2 WITHOUT PLUMED:

source /etc/profile.d/modules.sh

module purge
module load cmake/3.5.0
module load intel/18.4
module load gnu/4.9.2
module load openmpi/1.8.3/intel/any
module load cudatoolkit/10.0
export CMAKE_PREFIX_PATH=/home/bussi/modules/fftw/3.3.4/intel

#installdir=/u/sbp/bussi/modules/Gromacs5.0.4c/sse
#installdir=/u/sbp/bussi/modules/Gromacs2016.5
installdir=/home/mbernett/modules/GROMACS/gromacs-2018.4
umask 022

mkdir build-sp
cd build-sp

cmake .. \
    -DCMAKE_C_COMPILER:FILEPATH=$(which mpicc) \
    -DCMAKE_CXX_COMPILER:FILEPATH=$(which mpic++) \
    -DCMAKE_INSTALL_PREFIX:STRING=$installdir \
    -DGMX_MPI=ON

make -j 12

make install
cd ../


