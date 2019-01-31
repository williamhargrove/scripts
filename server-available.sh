#!/bin/bash

HOST_LIST=$1

while read ip app; do
 [[ "$ip" =~ ^#.*$ ]] && continue
 HOST=$ip
 echo -n "Checking if $ip is available ..."
 ping -c3 ${ip} > /dev/null && echo $ip is available || echo "$ip not available"
done < ./${HOST_LIST}
