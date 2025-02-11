#!/bin/zsh

# Get the serial number of the MacBook
serial_number=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

# Rename the MacBook
sudo scutil --set ComputerName "MacBook-$serial_number"
sudo scutil --set HostName "MacBook-$serial_number"
sudo scutil --set LocalHostName "MacBook-$serial_number"

echo "MacBook renamed to MacBook-$serial_number"

exit 0
