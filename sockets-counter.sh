#!/bin/bash

netstat -ant | awk 'NR>2' | awk '{print $6}' | sort | uniq -c
total=`netstat -ant | awk 'NR>2' | awk '{print $7}' | sort | uniq -c`

echo "Total: ${total}"


#netstat -ant | awk 'NR>2'| awk '{print $6}' | sort | uniq -c | sort -n | while read count name
#do
#        if [ ${count} -gt 1 ]
#        then
#                echo "${name} ${count}"
#        fi
#done