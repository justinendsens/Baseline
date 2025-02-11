#!/bin/bash

########## Touch condition file ##########

if [[ ! -f "/Library/Application Support/Enexis/Logs/org.enexis.log" ]]; then
    touch "/Library/Application Support/Enexis/Logs/org.enexis.log"
fi

exit
