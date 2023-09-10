#!/bin/sh

apk add curl jq

CURRENT_IP=$(curl --silent --header "Authorization: Bearer $API_KEY" https://dns.api.gandi.net/api/v5/domains/$DOMAIN/records/$SUBDOMAIN/A | jq -r ".rrset_values[0]")
EXTERNAL_IP=$(curl --silent ifconfig.io)
#EXTERNAL_IP="127.0.0.1"

JSON=$(cat <<EOF
{
    "items":[
        {"rrset_type":"A", "rrset_values":["${EXTERNAL_IP}"], "rrset_ttl": 900}
    ]
}
EOF
)

if [ $CURRENT_IP == $EXTERNAL_IP ]; then
    echo "Nothing to do."
else
    # Update the A Record of the subdomain using PUT
    curl https://api.gandi.net/v5/livedns/domains/$DOMAIN/records/$SUBDOMAIN \
        --request PUT \
        --header "Authorization: Bearer $API_KEY" \
        --header "Content-type: application/json" \
        --data "$JSON" \
        --silent
    echo "";
    echo "Updated $SUBDOMAIN.$DOMAIN A record to $EXTERNAL_IP."
fi
