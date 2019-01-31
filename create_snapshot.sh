#!/bin/bash

volume_id=${1}

aws ec2 create-snapshot --profile=PROFILE_NAME --volume-id ${volume_id} --description "Final snapshot of ${volume_id}" --tag-specifications 'ResourceType=snapshot,Tags=[{Key=Type,Value=final}]'
