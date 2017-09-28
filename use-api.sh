#!/bin/bash

if [ -z "$OS_AUTH_URL" ]; then
  if [ ! -f novarc ]; then
    echo "Error: no stackrc file was sourced."
    echo "try 'source stackrc' or similar first."
    exit 1
  fi
  source novarc
fi

scratch=$(mktemp)
function finish() {
  rm -f "$scratch"
}
trap finish EXIT

curl -s -d '
   {"auth": {
      "tenantName": "'$OS_TENANT_NAME'",
      "passwordCredentials": {
        "username": "'$OS_USERNAME'",
        "password": "'$OS_PASSWORD'"
       }
     }
   }' \
   -H "Content-type: application/json" \
   "$OS_AUTH_URL/tokens" > $scratch

token="$(jq -r '.access.token.id' $scratch)"
internal_url="$(jq -r '.access.serviceCatalog[] | select (.type == "identity") | .endpoints[].internalURL' $scratch)"
admin_url="$(jq -r '.access.serviceCatalog[] | select (.type == "identity") | .endpoints[].adminURL' $scratch)"
echo "Internal URL: $internal_url"
echo "Admin URL: $admin_url"
echo "Token: $token"
echo
echo "Tenants..."
curl -sH "X-Auth-Token:$token" "${internal_url}/tenants" | jq -r ".tenants[].name"
echo
echo "Users..."
curl -sH "X-Auth-Token: $token" ${admin_url}/users | jq -r ".users[].name"
