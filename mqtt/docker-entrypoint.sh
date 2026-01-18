#!/bin/sh
set -e

# Define paths
PASSWORD_FILE=/mosquitto/config/passwd
MOSQUITTO_CONF=/mosquitto/config/mosquitto.conf

# Create or clear the password file
touch "$PASSWORD_FILE"
# Ensure the file is empty (truncate)
: > "$PASSWORD_FILE"

echo "Generating MQTT password file..."

# Iterate through environment variables looking for MQTT_USER_n
# We will assume a reasonable limit or check until we don't find a user
i=1
while true; do
    # specific sh compatible way to get dynamic variable names
    user_var="MQTT_USER_$i"
    pass_var="MQTT_PASSWORD_$i"
    
    # eval to get the values
    user=$(eval echo \$$user_var)
    pass=$(eval echo \$$pass_var)

    if [ -z "$user" ]; then
        break
    fi

    if [ -z "$pass" ]; then
        echo "Warning: No password provided for user $user (index $i). Skipping."
    else
        echo "Adding user: $user"
        mosquitto_passwd -b "$PASSWORD_FILE" "$user" "$pass"
    fi

    i=$((i + 1))
done

echo "Starting Mosquitto..."
exec "$@"
