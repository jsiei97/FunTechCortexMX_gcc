#!/bin/bash 

function did_it_work {
    code=$1
    if [ ! $code = 0 ]
    then
        echo "Error failure: code $code "
        exit 1
    fi
}

stm_dir=~/stm32/
stm_dir_bin=$stm_dir"/bin"
stm_dir_tools=$stm_dir"/stm32-tools"
stm_dir_install=/usr/local/stm32

export TOOLPATH_STM32=$stm_dir_install
export PATH=$TOOLPATH_STM32/bin:$PATH
export PARALLEL=-j`getconf _NPROCESSORS_ONLN`

#What version of this project are we using?
export GIT_VERSION=`git describe --long --dirty`

