#!/bin/bash
CHECK="$(csrutil status | awk -F: '{print $2}' | tr -d ' .')";
if [ "$CHECK" = "disabled" ]; then
	echo "Before this command you must disactivate System Integrity Protection.";
	echo "  1) reboot your mac in recovery mode";
	echo "  2) csrutil enable";
	exit 1;
fi;
sudo systemextensionsctl list | grep cyberark | awk '{print "sudo systemextensionsctl uninstall "$3" "$4}' | bash
