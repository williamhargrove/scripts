#!/bin/bash

for tagid in $(cat ./bvi_demo.tag); do
 aws ec2 --profile=default create-tags --resources ${tagid} --tags Key="Cost Centre",Value="BVI Demo"
done
