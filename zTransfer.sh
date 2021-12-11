#! /bin/bash

read -p "Enter domain : " domain
echo -e "\nCollecting list of name servers"
dig $domain NS +short | tee nameservers.txt

echo -e "\nChecking if zone transfer is possible..."

for ns in $(cat nameservers.txt); do
	dig axfr $domain @"$ns"
done 

rm nameservers.txt