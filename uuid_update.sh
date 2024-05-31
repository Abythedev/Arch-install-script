#!/bin/bash

# Get the UUID of /dev/sda1
UUID=$(sudo blkid -s UUID -o value /dev/sda1)

# Define the timeshift.json file path
TIMESHIFT_JSON="timeshift.json"

# Use sed to replace the placeholder UUID with the actual UUID
sed -i "s/\"backup_device_uuid\" : \"[^\"]*\"/\"backup_device_uuid\" : \"$UUID\"/" "$TIMESHIFT_JSON"

echo "UUID replaced in timeshift.json"
