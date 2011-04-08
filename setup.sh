#!/bin/bash 

source include.sh

date=`date +"%F_%H%M%S"`

chmod 755 *.sh
did_it_work $? 

./install.sh 2>&1 | tee log_stm32_build_$date.log

