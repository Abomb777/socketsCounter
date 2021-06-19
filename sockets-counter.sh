#!/bin/bash

netstat -ant | awk 'NR>2' | awk '{print $6}' | sort | uniq -c
total=`netstat -ant | awk 'NR>2' | awk '{print $7}' | sort | uniq -c`

echo "Total: ${total}"

range=`cat /proc/sys/net/ipv4/ip_local_port_range`
therange=`echo $range | awk '{print $1}'`
totalsockets=`echo $range | awk '{print $2}'`
timelimit=`cat /proc/sys/net/ipv4/tcp_fin_timeout`
echo Total max sockets per sec $((($totalsockets-$therange) / $timelimit))
echo Free sockets $(((($totalsockets-$therange) / $timelimit)-$total))

#echo "${range}"


#netstat -ant | awk 'NR>2'| awk '{print $6}' | sort | uniq -c | sort -n | while read count name
#do
#        if [ ${count} -gt 1 ]
#        then
#                echo "${name} ${count}"
#        fi
#done