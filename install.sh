#!/bin/bash 

source include.sh

echo 
echo $GIT_VERSION
echo 

echo "Install some packages..."
./solve_dependencies.sh
did_it_work $? 

echo "Create the work dirs"
./create_dirs.sh
did_it_work $? 

echo "Build binutils"
./build_00_binutils.sh
did_it_work $? 

echo "Build gcc and newlib"
./build_01_gcc_newlib.sh
did_it_work $? 

echo "Build Insight"
./build_02_insight.sh
did_it_work $? 

echo "Build GDB"
./build_03_gdb.sh
did_it_work $? 

echo "Modify .bashrc"
echo "Add a file to modify the PATH..."
./add_rc_files.sh
did_it_work $? 

echo "Done:"$0
exit 0

