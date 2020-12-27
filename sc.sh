
echo " 

#!/bin/bash 

###################################################################################################################################################################
#Script Name	: Alpha-Basic-Scan                                                                       
#Description	: Here, all scanning tool like (Nmap,Nikto,dirb,whatsweb) are included in one script . Just insert target ip and all scanning done automatically . 
		  Don't need to scanning seprate in each tools. In last all tools throw output to Desktop .Here script also check is package are instlled 
		  or not before starting scanning.                                                                                                                                                              
#Author       	: Avadhesh Gupta                                
#Email         	: avdsgt@gmail.com  
#Twitter        : https://twitter.com/avdsgt
#Github         : https://github.com/avdsgt
#####################################################################################################################################################################"

echo "           _            __        
 /\ |._ |_  _.__|_) _. _o ___(_  _ _.._ 
/--\||_)| |(_|  |_)(_|_>|(_  __)(_(_|| |
     |                                  
"



echo "\e[7mTarget IP (Only IP):\e[27m \e[5m==>\e[25m"
read input
#Taking Only IP ...(Working To Convert DNS to IP { dig +short www.google.com | tail -n 1 }
echo "Creating New Directory For This Project!!"
echo "\e[5m Please Type Directory Name\e[25m"
read dir_name 
sleep 3
mkdir /root/Desktop/$dir_name #Each Project Creating New Directory

banner() #Created A Function For Funcky Banner 
{
  echo "+--------------------------------------------------------------------------------------+"
  printf "| 			%-62s |\n" "`date`"
  echo "|                            		 		  		               |"
  printf "|			`tput bold` %-61s `tput sgr0`|\n" "$@"
  echo "+--------------------------------------------------------------------------------------+"
}


checking() #Here we are checking available installed package in dpkg database
{	
dpkg -V $1 &> /dev/null

if [ $? -eq 0 ]; 
then
    echo "\e[4m $1 Package  Is  Already Installed! \e[24m"
else
echo "Package  Is NOT Installed!"
sleep 3
echo "\e[5mDo You Want To Install This Package??? IF Yes (1) Or No (0) !!" #If Package are not installed in DB here command automatically installed absent Package
read comm #grant permission
if [ $comm -eq '1' ]
then
	apt install $1
	echo "Pleas Wait"
else
echo "\e[5mWrong Entry"
fi
fi
}
#Each of Tool Create seprate file in output
banner "WHAT_WEB Scanning"
echo "Checking Package"
sleep 2  
checking "WHATWEB"
sleep 4
whatweb -v $input >> /root/Desktop/$dir_name/WHATS_WEB_$input #Seprate Output

banner "NMAP Scanning"
echo "Checking Package"
sleep 2  
checking "NMAP"
sleep 4
nmap -sV -A -T4 $input -oN /root/Desktop/$dir_name/NMAP_$input

banner "DIRB Scanning"
echo "Checking Package"  
sleep 2
checking "DIRB"
sleep 4
dirb http://$input -o /root/Desktop/$dir_name/DIRB_$input

banner "NIKTO Scanning"
echo "Checking Package"
sleep 2
checking "NIKTO"
sleep 4
nikto -host $input -Display 123 -Tuning 23 -output /root/Desktop/$dir_name/NIKTO_$input -Format txt

#Suggest Me More Tools For Enumeration and Scanning
