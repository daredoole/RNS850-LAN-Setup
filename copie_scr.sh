#!/bin/ksh
# 20220102 drger; MMI3G SD shell script launcher
export SDPATH=$1
export PATH=$PATH:${SDPATH}/bin
export SDLIB=${SDPATH}/lib
export SDVAR=${SDPATH}/var
export SWTRAIN="$(cat /dev/shmem/sw_trainname.txt)"
mount -u $SDPATH
cd $SDPATH
exec ksh ./run.sh $SDPATH
