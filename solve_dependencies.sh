#!/bin/bash 

source include.sh

echo "Install some depends (sudo may ask for your passwd)"
sudo aptitude install build-essential flex bison \
    libgmp3-dev libmpfr-dev autoconf \
    texinfo libncurses5-dev libexpat1 libexpat1-dev \
    tk tk8.4 tk8.4-dev
did_it_work $? 

echo "Done:"$0
exit 0
