#!/bin/bash 

source include.sh

#################
### GCC #########
#################

ver_gcc=gcc-4.6.2
arch_url=ftp://ftp.sunet.se/pub/gnu/gcc/releases/$ver_gcc/$ver_gcc.tar.bz2
arch_dir=$ver_gcc
arch_name=$ver_gcc.tar.bz2

cd $stm_dir_tools
did_it_work $? 

if [ -f $arch_name ]; then
    echo file exists - $arch_name
else
    wget $arch_url
    did_it_work $? 
fi

if [ -d $arch_dir ]; then
    echo old dir exists - rm -rf $arch_dir
    rm -rf $arch_dir
    did_it_work $? 
fi

tar -xvjf $arch_name
did_it_work $? 

cd $arch_dir
did_it_work $? 

mkdir build
did_it_work $? 
cd build
did_it_work $? 
../configure --target=arm-none-eabi  \
             --prefix=$TOOLPATH_STM32  \
             --enable-interwork  \
             --enable-multilib  \
             --enable-languages="c,c++"  \
             --with-newlib  \
             --without-headers  \
             --disable-shared  \
             --with-gnu-as  \
             --with-float=soft \
             --with-cpu=cortex-m3 \
             --with-tune=cortex-m3 \
             --with-mode=thumb \
             --disable-libssp \
             --with-gnu-ld \
	     --with-system-zlib 
did_it_work $? 

make $PARALLEL all-gcc 
did_it_work $? 
make install-gcc 
did_it_work $? 


#################
## NewLib #######
#################

ver=newlib-1.20.0

arch_url=ftp://sources.redhat.com/pub/newlib/$ver.tar.gz
arch_dir=$ver
arch_name=$ver.tar.gz

cd $stm_dir_tools
did_it_work $? 

if [ -f $arch_name ]; then
    echo file exists - $arch_name
else
    wget $arch_url
    did_it_work $? 
fi

if [ -d $arch_dir ]; then
    echo old dir exists - rm -rf $arch_dir
    rm -rf $arch_dir
    did_it_work $? 
fi

tar -xvzf $arch_name
did_it_work $? 

cd $arch_dir
did_it_work $? 
mkdir build
did_it_work $? 
cd build
did_it_work $? 
../configure --target=arm-none-eabi  \
             --prefix=$TOOLPATH_STM32  \
             --enable-interwork  \
             --with-gnu-ld  \
             --with-gnu-as  \
             --disable-shared 
did_it_work $? 

# Malloc issue:
# Shall we use the --disable-newlib-supplied-syscalls flag?

# Float issue:
# http://gcc.gnu.org/gcc-4.4/changes.html
# GCC now supports the VFPv3 variant with 16 double-precision 
# registers with -mfpu=vfpv3-d16. The option -mfpu=vfp3 has been 
# renamed to -mfpu=vfpv3.
# GCC now supports the -mfix-cortex-m3-ldrd option to work around 
# an erratum on Cortex-M3 processors.

# http://www.codesourcery.com/sgpp/lite/arm/portal/kbentry27
# Use the compiler options -mfpu=vfp -mfloat-abi=softfp to enable VFP instructions.
# If you have a VFPv3 target you may use -mfpu=vfp3 -mfloat-abi=softfp i
# to enable VFPv3 instructions.
# Using -mfloat-abi=hard generates code that is not ABI-compatible with 
# other floating-point options. 

#-mabi=aapcs 
# gcc 4.4.6 use -mfix-cortex-m3-ldrd ?


#-DREENTRANT_SYSCALLS_PROVIDED \
make $PARALLEL CFLAGS_FOR_TARGET="-ffunction-sections \
                        -fdata-sections \
                        -DPREFER_SIZE_OVER_SPEED \
                        -D__OPTIMIZE_SIZE__ \
                        -Os \
                        -fomit-frame-pointer \
                        -mcpu=cortex-m3 \
                        -mthumb \
                        -mfix-cortex-m3-ldrd \
                        -mfloat-abi=softfp \
                        -D__thumb2__ \
                        -D__BUFSIZ__=256" \
               CCASFLAGS="-mcpu=cortex-m3 \
                          -mthumb \
                          -mfix-cortex-m3-ldrd \
                          -D__thumb2__" 
did_it_work $? 

make install 
did_it_work $? 


#################
### More GCC ####
#################

cd $stm_dir_tools
did_it_work $? 
cd $ver_gcc/build
did_it_work $? 
make $PARALLEL CFLAGS="-mcpu=cortex-m3 -mthumb" \
     CXXFLAGS="-mcpu=cortex-m3 -mthumb" \
     LIBCXXFLAGS="-mcpu=cortex-m3 -mthumb" \
     all 
did_it_work $? 

make install 
did_it_work $? 



echo "Done:"$0
exit 0
