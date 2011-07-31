#!/bin/bash 

source include.sh

cat >> ~/.bashrc << EOF
# STM32 BEGIN
#Added by FunTechCortexMX_gcc - ${GIT_VERSION}
#Multi process build 
export PARALLEL=-j\`getconf _NPROCESSORS_ONLN\`

#STM32 gcc...
export TOOLPATH_STM32=`echo $stm_dir_install`
#export PATH=\${TOOLPATH_STM32}/bin:\$PATH
# STM32 END

EOF
did_it_work $? 


cat > $stm_dir_bin/funtech_stm32_setup.sh << EOF
#Autogen do not edit...
#Created by FunTechCortexMX_gcc - ${GIT_VERSION}
export PATH=${TOOLPATH_STM32}/bin:\$PATH

EOF
did_it_work $? 


echo "Done:"$0
exit 0
