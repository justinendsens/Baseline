#!/bin/bash

# Path to SwiftDialog
dialog='/usr/local/bin/dialog'

# get loggedInUser user
loggedInUser=$( /usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | /usr/bin/awk '/Name :/ { print $3 }' )
loggedInUserID=$( /usr/bin/id -u "$loggedInUser" )
realName=$(/usr/libexec/PlistBuddy -c "print :dsAttrTypeStandard\:RealName:0" /dev/stdin <<< $(dscl -plist . read /Users/$loggedInUser RealName))

runAsUser() {
  if [ "$loggedInUser" != "loginwindow" ]; then
    uid=$(id -u "$loggedInUser")
    /bin/launchctl asuser "$uid" sudo -u "$loggedInUser" "$@"
  fi
}

###########################################################################################################################################################################
# Display the Welcome message using swiftDialog
###########################################################################################################################################################################

runAsUser $dialog \
--blurscreen \
--ontop \
--title "Gefeliciteerd met je nieuwe MacBook!" \
--icon "https://dev.azure.com/ENX-WPL/12456404-0439-4ea9-85c2-7f079cb5d4e3/_apis/git/repositories/e5ea4662-6cac-4c40-900d-57018fbf05a6/items?path=/Baseline/pictures/logos/logo.png&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=main&resolveLfs=true&%24format=octetStream&api-version=5.0" \
--message "Hoi $realName,\n\nWe gaan je helpen om alles in te stellen en de juiste programma's te installeren.\n\nAls de installatie klaar is, zie je een knop met **Herstart**. Klik daarop om je MacBook opnieuw op te starten en de installatie af te ronden.\n\n Dit kan even duren, dus heb geduld...." \
--messagefont "size=14" \
--bannerimage "https://dev.azure.com/ENX-WPL/12456404-0439-4ea9-85c2-7f079cb5d4e3/_apis/git/repositories/e5ea4662-6cac-4c40-900d-57018fbf05a6/items?path=/Baseline/pictures/logos/banner.png&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=2&versionDescriptor%5Bversion%5D=c8562faef3a5aa1990be86e0bd5744c04311528c&resolveLfs=true&%24format=octetStream&api-version=5.0" \
--button1text "Aan de slag" \
--titlefont "size=20" \
--timer "120" \
--big

# After the button is pressed, exit the script
exit 0
