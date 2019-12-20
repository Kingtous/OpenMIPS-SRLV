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
ExecStep $xv_path/bin/xsim openmips_behav -key {Behavioral:sim_1:Functional:openmips} -tclbatch openmips.tcl -log simulate.log
