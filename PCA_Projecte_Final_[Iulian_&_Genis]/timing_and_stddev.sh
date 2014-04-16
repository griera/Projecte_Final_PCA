#!/bin/bash

## Usage
usage ()
{

echo "Usage: ${0} input nexec step"
echo "Where:"
echo "    - input: Specifies the arguments will be passed to ftdock program at command line."
echo "             Only \"test1\", \"test2\" or \"test3\" are correct values."
echo "             Each value corresponds to the following input arguments of ftdock program:"
echo "                 · test1: -static 2pka.parsed -mobile 5pti.parsed"
echo "                 · test2: -static 1hba.parsed -mobile 5pti.parsed"
echo "                 · test3: -static 4hhb.parsed -mobile 5pti.parsed"
echo ""
echo "    - nexec: Specifies the number of times ftdock program will be executed during the test."
echo ""
echo "    - step: Specifies the optimization applied to the current version of ftdock program."
echo "            This value should be a number (indicating an order for example)."
exit

}

## Command line paramethers
INPUT=$1
NEXEC=$2
STEP=$3

## Check arguments passed by command line
if [[ -z "${INPUT}" || -z "${NEXEC}" || -z "${STEP}" ]]
then
	usage
fi

## Choose the corresponding input arguments to ftodck program depending on INPUT value

if [ ${INPUT} == "test1" ]
then
	INPUT="-static 2pka.parsed -mobile 5pti.parsed"

elif [ ${INPUT} == "test2" ]
then
	INPUT="-static 1hba.parsed -mobile 5pti.parsed"

elif [ ${INPUT} == "test3" ]
then
	INPUT="-static 4hhb.parsed -mobile 5pti.parsed"
else
	usage
fi


## Output file to prove the correctness of current version of ftdock program
## Also create a directory (if it does not exists) to redirect the output
OUTPUT_FILE="opt${STEP}_output_${1}.txt"

if [ ! -d "opt${STEP}" ]
then
	mkdir opt${STEP}
fi

## Execute ftdock program in order to generate the output and compare it over the correct ouput
./ftdock ${INPUT} 2>&1 1>opt${STEP}/${OUTPUT_FILE} 2>/dev/null 

echo ""
echo "*** SUCCESS ***: ftdock has been executed successfully."
echo "Generated output (named ${OUTPUT_FILE}) can be found inside ${PWD}/opt${STEP} folder."

## Measure CPU time of ftdock program during NEXEC executions
echo ""
echo "Now ftdock program will be executed ${NEXEC} times in order to compute the following information:"
echo "  -CPU time of the instrumented part (delimited by PCA rules) for each execution."
echo "  -Average CPU time."
echo "  -Standard deviation of the test."
echo ""
echo "This test may take a few minutes, depending on number of executions and the input argument specified at command line."
echo "Please be patient..."
echo ""

j=0
sum_time=0
while [ $j -lt $NEXEC ]; do
	time=$(./ftdock ${INPUT} 2>&1 1>/dev/null)
	sum_time=$(echo "$sum_time + $time" | bc -l | awk '{printf "%.6f", $0}')
	VECTOR_TIMES[$j]=$time
	let j=$j+1
	echo "Execution ${j}: ${time} seconds."
done

## Compute the average time
avg_time=$(echo "$sum_time/$NEXEC" | bc -l | awk '{printf "%.6f", $0}')

## Compute standard deviation for the previous populations
acum=0
for i in "${VECTOR_TIMES[@]}"; do
	acum=$(echo "$acum + (($i - $avg_time)^2)" | bc -l)
done

stddev=$(echo "sqrt(($acum/($NEXEC - 1)))" | bc -l | awk '{printf "%.6f", $0}')


## Write the final results
echo ""
echo "*** SUCCESS ***: The script has finished successfully"

#echo "${VECTOR_TIMES_ORIG[@]}" > time_results_original.txt

echo ""
echo "The average CPU time of ftdock program is: ${avg_time} seconds."

echo ""
echo "The standard deviation of ftdock program with $NEXEC executions is: ${stddev}"

