#!/bin/bash
# do arping and filter responding/alive IPs
# depending on the situation you might need the
# -I interface (eth0, tap0, etc) flag 
for ip in $(seq 0 254); do /usr/bin/arping -c 1 10.1.1.$ip;done | grep -i "unicast reply"
