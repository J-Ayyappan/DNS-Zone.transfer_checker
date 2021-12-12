#! /bin/bash

read -p "Enter domain : " domain
echo -e "\nCollecting list of name servers"
dig $domain NS +short | tee nameservers.txt

if [[ $(cat nameservers.txt | wc -l) != 0 ]]  
then
	echo -e "\nChecking if zone transfer is possible..."

	for ns in $(cat nameservers.txt); do
		dig axfr $domain @"$ns"
	done 
else
	echo "Could not find name servers. Please check the domain name."
fi

rm nameservers.txt
