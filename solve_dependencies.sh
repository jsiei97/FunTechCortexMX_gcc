#!/bin/bash 

source include.sh

package_list="build-essential flex bison \
    libgmp3-dev libmpfr-dev autoconf \
    texinfo libncurses5-dev libexpat1 libexpat1-dev \
    tk tk8.4 tk8.4-dev"

#First check if we need to install anything?
dpkg -L $package_list 2>&1 > /dev/null 
if [ ! $? = 0 ]
then
    echo "Install some depends (sudo may ask for your passwd)"
    sudo aptitude install $package_list
    did_it_work $? 
fi

echo "Done:"$0
exit 0
