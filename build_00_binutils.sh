#!/bin/bash 

source include.sh

arch_url=http://ftp.gnu.org/gnu/binutils/binutils-2.20.tar.bz2
arch_dir=binutils-2.20
arch_name=binutils-2.20.tar.bz2

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

#Get patch/patches...
patch_file=binutils-2.20_tc-arm.c.patch
if [ -f $patch_file ]; then
    echo file exists - $patch_file
else 
    wget http://fun-tech.se/stm32/gcc/binutils-2.20_tc-arm.c.patch
    did_it_work $? 
fi
patch $arch_dir/gas/config/tc-arm.c $patch_file
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
             --with-gnu-as  \
             --with-gnu-ld  \
             --disable-nls 
did_it_work $? 

make $PARALLEL 
did_it_work $? 
make install 
did_it_work $? 


echo "Done:"$0
exit 0
