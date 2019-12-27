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
ExecStep $xv_path/bin/xsim openmips_min_sopc_tb_behav -key {Behavioral:sim_1:Functional:openmips_min_sopc_tb} -tclbatch openmips_min_sopc_tb.tcl -view /home/parallels/vproject/general_reg/openmips_min_sopc_tb_behav.wcfg -log simulate.log
