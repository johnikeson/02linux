#!/bin/bash

#This script downloads a zip file, creates a new user, unzips, installs and runs the application

apt update
apt install -y nodejs npm curl net-tools

node --version && npm --version

NEW_USER=myapp
read -p "Enter log file directory : " LOG_DIRECTORY

# Check if app folder exist, delete and create it again if it exist
if [ -d $LOG_DIRECTORY ]
then
  echo "$LOG_DIRECTORY already exists"
else
  mkdir -p "$LOG_DIRECTORY"
  echo "A new directory $LOG_DIRECTORY has been created"
fi

useradd "$NEW_USER" -m

chown "$NEW_USER" -R "$LOG_DIRECTORY"

# Check if archive.tgz exist
# fetch NodeJS project archive from s3 bucket
runuser -l $NEW_USER -c "wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

# extract the project archive to ./package folder
runuser -l $NEW_USER -c "tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz"

echo "Creating a new user...Please wait"
echo "New user $New_User created"

sleep 2
echo

sleep 5


runuser -l $NEW_USER -c "
    export APP_ENV=dev && 
    export DB_PWD=mysecret && 
    export DB_USER=myuser && 
    export LOG_DIR=$LOG_DIRECTORY && 
    cd package && 
    npm install && 
    node server.js &"



ps aux | grep node | grep -v grep

netstat -ltup | grep node
#lsof -i :3000





