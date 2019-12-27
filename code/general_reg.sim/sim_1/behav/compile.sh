#!/bin/bash -f
xv_path="/home/parallels/XiLinx/Vivado/2017.1"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
echo "xvlog -m64 --relax -prj openmips_min_sopc_tb_vlog.prj"
ExecStep $xv_path/bin/xvlog -m64 --relax -prj openmips_min_sopc_tb_vlog.prj 2>&1 | tee compile.log
