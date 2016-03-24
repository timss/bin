#!/usr/bin/env sh

# lanuptime.sh:
# show uptime of hosts in local subnet

set -e

skip=${1:-"localhost"}
default_if=$(ip route list | awk '/^default/ {print $5}')
subnet=$(ip -o -f inet addr show $default_if | awk '{print $4}')
hosts=$(nmap -sn $subnet | awk -F '[ ().]' '/for [a-z]+/ {print $5}' | grep -v $skip)

for host in $hosts; do
    echo -n "$host: " && ssh $host uptime | awk -F '[ , ]' '{print $4" "$5}'
done
