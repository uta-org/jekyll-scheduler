#!/bin/bash

IFS="="
while read -r name value
do
# echo "Content of $name is ${value//\"/}"

done < "sch.ini"
