#!/bin/bash

./technolife.sh > tmp.txt
TIME=$(grep '1 passing' tmp.txt | awk '{print $7}' | tr -d '()s' | sed 's/[^0-9.]//g')
grep '1 passing' tmp.txt
if [ $? -eq 0 ]
then
	zabbix_sender -z 192.168.212.3 -p 10051 -s "technolife" -k time -o $TIME
	zabbix_sender -z 192.168.212.3 -p 10051 -s "technolife" -k log -o 'login successful'
else
	zabbix_sender -z 192.168.212.3 -p 10051 -s "technolife" -k time -o 0
	zabbix_sender -z 192.168.212.3 -p 10051 -s "technolife" -k log -o 'login unsuccessful'
fi
rm tmp.txt
