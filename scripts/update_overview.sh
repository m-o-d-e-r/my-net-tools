#!/usr/bin/bash


get_access_token () {
    if [ "$#" -lt 2 ]; then
        echo "Error: Insufficient parameters." >&2
        return 1
    fi

    local auth_response=$(curl -s -L -H 'Content-Type: application/json' \
        -d "{\"identifier\":\"$1\",\"secret\":\"$2\"}" \
        -X POST https://hub.docker.com/v2/auth/token)

    if [ $? -ne 0 ]; then
        echo "Error: Request failed." >&2
        return 2
    fi

    local access_token=$(echo "$auth_response" | jq -r .access_token)

    if [ -z "$access_token" ] || [ "$access_token" = "null" ]; then
        echo "Error: Access token not found." >&2
        return 3
    fi

    echo "$access_token"
}

access_token=$(get_access_token "$DOCKERHUB_USERNAME" "$DOCKERHUB_TOKEN")
if [ $? -eq 0 ]; then
    echo "Successfully obtained access token."
else
    echo "Failed to obtain access token."
fi

overview_update_response=$(jq -n --arg msg "$(<README.md)" '{"full_description": $msg }' | \
    curl -s -L \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${access_token}" \
        -d @- -X PATCH https://hub.docker.com/v2/repositories/$DOCKERHUB_USERNAME/my-net-tools/
    )
if [ $? -eq 0 ]; then
    echo "Successfully updated repository overview."
else
    echo "Failed to update repository overview."
fi

echo $overview_update_response
