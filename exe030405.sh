#!/bin/bash

# This bash script prints  all the processes running for the current user and sorts based on request
# User Processes Sorted
# Number of User Processes Sorted

echo "This bash script prints all the processes running for the current user"
echo "How whould you like the process to be sorted"
echo
read -p "m to sort by Memory OR c to sort by CPU : " sort
echo
read -p "How many line items do you want displayed : " limit 

if [ $sort == "m" ]; then
	ps aux --sort +pmem | grep $(whoami) | head -$limit
elif [ $sort == "c" ]; then
	ps aux --sort +pcpu | grep $(whoami) | head -$limit
else
        echo
	echo "Your sort choice is not recognised"
fi
