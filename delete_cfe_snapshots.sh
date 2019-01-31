#!/bin/bash


# tag all snapshots taken on 1st of Month as monthly

# get a list of all daily snapshots
aws ec2 --profile=cfe describe-snapshots --owner-ids ACCOUNT_NUMBER --filters Name=tag:"Type",Values="daily" --query "Snapshots[*].{Time:StartTime,ID:SnapshotId}" --output text > /var/tmp/.all_snapshots_by_timestamp

while read snapid starttime; do
 date=$(echo ${starttime} | cut -d 'T' -f 1)
 day=$(echo ${date} |cut -d '-' -f 3)

 if [ ${day} -eq 01 ]; then
  echo "1st day of month - tagging as type=monthly"
  aws ec2 --profile=cfe create-tags --resources ${snapid} --tags Key="Type",Value="monthly"
 fi
done < /var/tmp/.all_snapshots_by_timestamp

# delete all month snapshots older than 1 year
date_365days_ago=$(date --date="-365 days" +%F)
monthly_snapshots_to_delete=$(aws ec2 --profile=cfe describe-snapshots --owner-ids ACCOUNT_NUMBER --filters Name=tag:"Type",Values="monthly" --query "Snapshots[?StartTime<='${date_365days_ago}'].SnapshotId" --output text)

for snap in ${monthly_snapshots_to_delete}; do
  echo "Deleting monthly snapshot $snap - greater than 12 months old"
  aws ec2 --profile=cfe delete-snapshot --snapshot-id $snap
done

# date 5 days ago
date_5days_ago=$(date --date="-5 days" +%F)

# delete all daily snapshots older than 5 days
daily_snapshots_to_delete=$(aws ec2 --profile=cfe describe-snapshots --owner-ids ACCOUNT_NUMBER --filters Name=tag:"Type",Values="daily" --query "Snapshots[?StartTime<='${date_5days_ago}'].SnapshotId" --output text)

for snap in ${daily_snapshots_to_delete}; do
  echo "Deleting daily snapshot $snap - greater than 5 days old"
  aws ec2 --profile=cfe delete-snapshot --snapshot-id $snap
done
