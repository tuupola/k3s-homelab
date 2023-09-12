#!/bin/sh

apk add curl jq

CURRENT_IP=$(
    curl https://dns.api.gandi.net/api/v5/domains/$DOMAIN/records/$SUBDOMAIN/A \
        --silent \
        --header "Authorization: Bearer $API_KEY" \
    | jq -r ".rrset_values[0]" \
)
EXTERNAL_IP=$(curl --silent ifconfig.io)
TTL=900
#EXTERNAL_IP="127.0.0.1"

JSON=$(cat <<EOF
{
    "items":[
        {"rrset_type":"A", "rrset_values":["${EXTERNAL_IP}"], "rrset_ttl": ${TTL}}
    ]
}
EOF
)

# Make sure we have the CURRENT_IP
if [ -z  ${CURRENT_IP} ]; then
    echo "Failed to get CURRENT_IP."
    exit 1
fi

# Make sure we have the EXTERNAL_IP
if [ -z ${EXTERNAL_IP} ]; then
    echo "Failed to get EXTERNAL_IP."
    exit 1
fi

# Make sure EXTERNAL_IP has changed
if [ ${CURRENT_IP} == ${EXTERNAL_IP} ]; then
    echo "${CURRENT_IP} == ${EXTERNAL_IP}, nothing to do."
else
    curl https://api.gandi.net/v5/livedns/domains/${DOMAIN}/records/${SUBDOMAIN} \
        --request PUT \
        --header "Authorization: Bearer ${API_KEY}" \
        --header "Content-type: application/json" \
        --data "${JSON}" \
        --silent
    echo "";
    echo "Updated ${SUBDOMAIN}.${DOMAIN} A record to ${EXTERNAL_IP}."
fi
