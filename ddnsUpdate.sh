#!/bin/bash

### Google Domains provides an API to update a DNS "Syntheitc record". This script
### updates a record with the script-runner's public IP, as resolved using a DNS
### lookup.
###
### Google Dynamic DNS: https://support.google.com/domains/answer/6147083
### Synthetic Records: https://support.google.com/domains/answer/6069273

USERNAME="change this"
PASSWORD="change this"
HOSTNAME="change this"

# Get lastIP
LIP=$(head -n 1 lastIP)

# Resolve current public IP
IP=$(curl -4s "https://domains.google.com/checkip")

# Compare lastIP to current and save current
if [[ "${LIP}" != "${IP}" ]]
then
    LIP="${IP}"
    echo "${IP}" > lastIP

    # Update Google DNS Record
    URL="https://username:password@domains.google.com/nic/update?hostname=${HOSTNAME}&myip=${IP}"
    curl --user ${USERNAME}:${PASSWORD} -sw '\n' $URL
fi
