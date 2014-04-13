#!/bin/bash
# file: fins_minimum.sh
# beginning at maxstep=1, program finds the minimum number of steps
# required for a provided program to complete
#
# first argument to the function is the program to run through clingo
# it is assumed that the program shoudl be run with the only argument
# as "-c maxstep=I" as below so any additional arguments to clingo
# should be specified along with the program name
#
# defaults include:
#	starting at maxstep=1
#	run robot_movement as the program if no argument is specified

#GRIPPERS=2
#COMMAND="./clingo bw_p4 -c maxstep=${I} -c grippers=${GRIPPERS} 1"
#COMMAND="./clingo bw_p3 -c maxstep=${I} -c grippers=${GRIPPERS} 1"
#COMMAND="./clingo robot_movement -c maxstep=${I} 1"
if [ -z $1 ] 
then 
	PROGRAM="robot_movement"
else
	PROGRAM=$1
fi
echo "Program: $PROGRAM"
FILENAME_OUT=${PROGRAM}_out
echo "Saving output to <${FILENAME_OUT}>"
if [ -z $2 ]
then
	I=54
else
	I=$2
fi
echo "Beginning at $I maximum steps"
RESULT="" #$(${COMMAND} | grep "^SATISFIABLE" --color=auto)
#echo $RESULT
while [ -z ${RESULT} ]
do 
    I=$(( $I + 1 ))
	#echo $I
	#COMMAND="./clingo robot_movement -c maxstep=${I} 1"
	COMMAND="./clingo ${PROGRAM} -c maxstep=${I} 1"
    echo $COMMAND
    RESULT=$(${COMMAND} | grep "^SATISFIABLE" --color=auto)
    #echo $RESULT
done
echo
echo "Minimum number of steps = ${I}:"
time ${COMMAND} > $FILENAME_OUT 
grep -P "\b(left|up|right|down|pickup|place)\b" $FILENAME_OUT --color=auto
echo
