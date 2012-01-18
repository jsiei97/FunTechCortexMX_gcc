#!/bin/bash 

source include.sh

#################
### insight #####
#################

arch_url=ftp://sourceware.org/pub/insight/releases/insight-6.8-1a.tar.bz2
arch_dir=insight-6.8-1
arch_name=insight-6.8-1a.tar.bz2
gdb_ver=6.8

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
../configure --target=arm-none-eabi \
                      --prefix=$TOOLPATH_STM32 \
                      --enable-languages=c,c++ \
                      --enable-thumb \
                      --enable-interwork \
                      --enable-multilib \
                      --enable-tui \
                      --with-newlib \
                      --disable-werror \
                      --disable-libada \
                      --disable-libssp \
                      --with-expat 
did_it_work $? 

make $PARALLEL 
did_it_work $? 
make install 
did_it_work $? 

cd $TOOLPATH_STM32/bin
did_it_work $? 
mv arm-none-eabi-gdb    arm-none-eabi-gdb-$gdb_ver
did_it_work $? 
mv arm-none-eabi-gdbtui arm-none-eabi-gdbtui-$gdb_ver
did_it_work $? 
mv arm-none-eabi-run    arm-none-eabi-run-$gdb_ver
did_it_work $? 

echo "Done:"$0
exit 0
