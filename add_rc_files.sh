#!/bin/bash 

source include.sh

cat >> ~/.bashrc << EOF
# STM32 BEGIN
#Multi process build 
export PARALLEL=-j\`getconf _NPROCESSORS_ONLN\`

#STM32 gcc...
export TOOLPATH_STM32=`echo $stm_dir_install`
#export PATH=\${TOOLPATH_STM32}/bin:\$PATH
# STM32 END

EOF
did_it_work $? 


cat > $stm_dir_bin/stm32_setup.sh << EOF
#Autogen do not edit...
export PATH=${TOOLPATH_STM32}/bin:\$PATH

EOF
did_it_work $? 


echo "Done:"$0
exit 0
