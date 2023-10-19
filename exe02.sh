#!/bin/bash

# This script is used to install java, but it checks first if it exist

java --version > /dev/null 2>&1

if  [[ ! $? == 0 ]]; then
	sudo apt-get install -y default-jre

	if  [[ $(java --version | head -n 1 | awk {'print $2'} | cut -d'.' -f1,1) -ge 11 ]]; then
                echo "Installation successful, you have java version 11 or higher installed"

	elif [[ $(java --version | head -n 1 | awk {'print $2'} | cut -d'.' -f1,1) -lt 11 ]]; then
                echo "You have an older version of java installed"
        fi
else 
	echo "You have java installed"

fi
