#!/bin/bash

USERID=$(id -u)

# check root access or not

if [ $USERID -ne 0 ]; then
    echo "Run this script with root priviliges"
    exit 1
fi

# first arg --> What you are trying to install..
# second arg --> exit code

dnf list installed mysqld
if [ $? -eq 0 ]; then
    echo "MySQL is already installed.. Skipping.."
else 
    echo "Installing MySQL"
    dnf install mysqld -y
fi