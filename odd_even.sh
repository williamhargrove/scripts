#!/bin/bash

i=0

while [ $i -le 20 ]; do
 echo $i
 let x="$i % 2"
 if [[ let x="$i % 2" ]]; then 
  echo "$i is EVEN"
 else
  echo "$i is ODD"
 fi
 let i++
done
