#!/bin/bash

I=1
GRIPPERS=2
#COMMAND="./clingo bw_p4 -c maxstep=${I} -c grippers=${GRIPPERS} 1"
#COMMAND="./clingo bw_p3 -c maxstep=${I} -c grippers=${GRIPPERS} 1"
COMMAND="./clingo robot_movement -c maxstep=${I} 1"

echo $COMMAND
RESULT=$(${COMMAND} | grep "^SATISFIABLE" --color=auto)
#echo $RESULT
while [ -z ${RESULT} ]
do 
    I=$(( $I + 1 ))
	#    echo $I
	COMMAND="./clingo robot_movement -c maxstep=${I} 1"
    echo $COMMAND
    RESULT=$(${COMMAND} | grep "^SATISFIABLE" --color=auto)
#    echo $RESULT
done
echo
echo "Minimum number of steps = ${I}:"
RESULT=$(time ${COMMAND} )
echo $RESULT
echo
