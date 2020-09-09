#!/bin/bash


#a variable with  a list of values. space is the value separator
IPS="129.55.3.4 10.0.0.1 5.5.5.5 4.4.4.4"

#$ in front of the variable name gets the value of that variable
echo "The value of variable IPS is $IPS"


#######BUILT-IN VARIABLES####################
#$1 is the first argument of the script
#\ escape the $ char (it will print $1 literally)
echo "\$1 is $1"

#$2 is the first argument of the script
echo "\$2 is $2"


#$3 is the first argument of the script
echo "\$3 is $3"


#$4 is the first argument of the script
echo "\$4 is $4"

#$# represents the no. of arguments the script was called with
echo "\$# is $#"
################################################
#iterate through the list of IPs
#a variable named IP is created and in every loop it has a value from the list 
for IP in $IPS 
do
	echo "IP is $IP"
done

#if no . of argments not equals 0
if [ $# -ne 0 ] 
then

	#if first script argument equals
	if [ $1 -eq 55 ]
	then
 		echo "\$1 is 55"
	else
 		echo "\$1 is not 55"
	fi

else
	echo "script was run without arguments"
fi


