#!/bin/bash

USERID=$(id -u)
LOGS_DIR=/var/log/shell-script
LOGS_FILE="$LOGS_DIR/$0.log"

# check root access or not

if [ $USERID -ne 0 ]; then
    echo "Run this script with root priviliges"
    exit 1
fi

# first arg --> What you are trying to install..
# second arg --> exit code

VALIDATE(){
    if [ $2 -ne 0 ];then
        echo "Installing $1 is failed.."
        exit 1
      else
        echo "Installing $1 is success.."
    fi
}

for package in "$@"
do 
    echo "Installing $package"
    dnf list installed $package
    if [ $? -ne 0 ];then
    dnf install $package -y &>> $LOGS_FILE 
    VALIDATE "Installing $package" $?
    else
        echo "$package is already installed.. SKIPPING"
    fi
done