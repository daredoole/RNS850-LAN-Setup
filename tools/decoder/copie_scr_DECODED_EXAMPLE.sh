#!/bin/ksh
# 20231112 drger; Added MMI3GB
# 20221220 drger; Added MUVER
# 20220103 drger; MMI3G/MMI3GP SD shell script launcher
export SDPATH=$1
export PATH=${PATH}:${SDPATH}/bin
export SDLIB=${SDPATH}/lib
export SDVAR=${SDPATH}/var
export MUVER="n/a"
export SWTRAIN="n/a"
if [ -e /etc/pci-3g_9304.cfg