#!/usr/bin/bash



#list the supported options letters"
options=":vn"


#flag vars corresponding to the options to know if they were set
n=0
v=0

#help message
helpmessage="enter command in format: $0 searchword testfile.txt"

#iterate over the included options and set the variable of the found option, either -n or -v, else show help message
while getopts ":vn" opt; 
do
	case ${opt} in
	  n)
	    n=1

	    ;;
	  v)
	    v=1

	    ;;
	    
	  ?)
	    echo "invalid option!"
	    echo $helpmessage
	    exit 1
	    
	    ;;
	esac
done

#now the OPTIND var will bear the index of the next argument so we will shift it back by the number of steps taken -1 to 
#stop at arg1 ex: $mygrep.sh -v -n hello testfile.txt then after going over -n and -v the OPTIND will be 3 so we will 
#shift by OPTIND-1 to reset back to the first mandatory argument  
shift "$(($OPTIND -1))"

#check the number of arguments
if [ $# -eq 0 ]
then
	echo "arguments missing!"
	exit 1
#if only one argument is found, then it will be considered as the testfile name
elif [ $# -eq 1 ]
then
	echo -e "warning: missing search string!\n"
	file=$1
	#if v==0 then we will exit (no matching lines)
	if [ $v -eq 0 ]
	then
		exit 1
	#elif v==1 then we will list all lines as all will be considered complement to an empty string
	elif [ $v -eq 1 ]
	then
		#check for n variable if n==1 then loop over all lines, print them, and include the line index
		if [ $n -eq 1 ]
		then
			ctr=1
			while read -r line
			do
				echo $line $ctr
			ctr=$(($ctr+1))
			done	< $file
		
		#check for n variable if n==0 then loop over all lines and print them
		else
			while read -r line
			do
				echo $line
			done	< $file
		fi
	exit 1
	fi
#if number of args is equal 2 then assign them to word and file vars	
elif [ $# -eq 2 ]
then
	word=$1
	file=$2
#else exit
else
	echo "too many arguments!"
	exit 1
fi

  
#ctr variable to keep track of lines indices in case -n was included	    
ctr=1

#loop over all testfile's lines
while read -r line
do
	#check variable contains gets the lines containing the keyword. Otherwise will be empty
	check=$(echo $line | grep -i $word --color=always)
	
	#if check is not empty and v==0
	if [ ! -z "${check}" ] && [ $v -eq 0 ]
	then
		#check for n var if n==1 then print the matching line as well as its index
		if [ $n -eq 1 ]
		then
			echo -e $check $ctr
		#else print only the matching lines
		else
			echo -e $check
		fi
	#if check is empty and v==1
	elif [ -z "${check}" ] && [ $v -eq 1 ]
	then
		#check for n var if n==1 then print the complement line as well as its index
		if [ $n -eq 1 ]
		then
			echo -e $line $ctr
		#else print only the complement lines
		else
			echo -e $line
		fi
	
	fi
	#update line index
	ctr=$(($ctr+1))
done	< $file


