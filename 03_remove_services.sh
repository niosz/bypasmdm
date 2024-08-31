#!/bin/bash
CHECK="$(csrutil status | awk -F: '{print $2}' | tr -d ' .')";
if [ "$CHECK" = "disabled" ]; then
	echo "Before this command you must disactivate System Integrity Protection.";
	echo "  1) reboot your mac in recovery mode";
	echo "  2) csrutil enable";
	exit 1;
fi;
CHECK="$(id | tr '()' '§§' | awk -F'§' '{print $2}')";
if [ ! "$CHECK" = "root" ]; then
	echo "This command must be run from root user.";
	exit 1;
fi; 
ls "/Library/LaunchAgents" | grep -E "jamf|microsoft|pulsesecure|adobe" | awk '{print "mv \"/Library/LaunchAgents/"$0"\" \"/Library/LaunchAgents/"$0"_disabled\""}' | bash;
ls "/Library/LaunchDaemons/" | grep -E "jamf|microsoft|pulsesecure|adobe" | awk '{print "mv \"/Library/LaunchAgents/"$0"\" \"/Library/LaunchDaemons//"$0"_disabled\""}' | bash;
rm -rf /Applications/OneDrive.app
