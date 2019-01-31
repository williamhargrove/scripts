#!/bin/bash

volume_id=${1}

aws ec2 delete-volume --profile=PROFILE_NAME --volume-id ${volume_id}
