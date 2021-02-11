#!/bin/bash

set -e 

ERR="The script at `pwd`/getip.sh requires the jq application. Please install and re-apply"

ADMIN_IP="`dig +short myip.opendns.com @resolver1.opendns.com`"

command -v jq >/dev/null 2>&1 || { echo >&2 "$ERR"; exit 1; }

jq -n --arg adminip "$ADMIN_IP" '{"adminip":$adminip}'
