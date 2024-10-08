#!/bin/bash
# ------------------------------------------------------------------------------------- script configuration
MUST_SIP_DISABLED=0;
MUST_IS_USER_ROOT=1;
MUST_HAVE_NODE_JS=0;

# ------------------------------------------------------------------------------------- protection disabled
if [ $MUST_SIP_DISABLED -eq 1 ]; then
	CHECK="$(csrutil status | awk -F: '{print $2}' | tr -d ' .')";
	if [ "$CHECK" = "enabled" ]; then
		echo "Before this command you must disactivate System Integrity Protection.";
		echo "  1) reboot your mac in recovery mode";
		echo "  2) csrutil disable";
		exit 1;
	fi;
fi;

# ------------------------------------------------------------------------------------- run user is root
if [ $MUST_IS_USER_ROOT -eq 1 ]; then
	CHECK="$(id | tr '()' '§§' | awk -F'§' '{print $2}')";
	if [ ! "$CHECK" = "root" ]; then
		echo "This command must be run from root user.";
		exit 1;
	fi; 
fi;

# ------------------------------------------------------------------------------------- nodejs is installed
if [ $MUST_HAVE_NODE_JS -eq 1 ]; then
	CHECK="$(node -e 'console.log(2+2);' 2>/dev/null)";
	if [ $CHECK -ne 4 ]; then
		echo "NodeJS is not present on machine, must be installed for run.";
		exit 1;
	fi;
fi;

# ------------------------------------------------------------------------------------- main code

ls "/Library/LaunchAgents" | grep -E "jamf|microsoft|pulsesecure|adobe" | awk '{print "mv \"/Library/LaunchAgents/"$0"\" \"/Library/LaunchAgents/"$0"_disabled\""}' | bash;
ls "/Library/LaunchDaemons/" | grep -E "jamf|microsoft|pulsesecure|adobe" | awk '{print "mv \"/Library/LaunchAgents/"$0"\" \"/Library/LaunchDaemons/"$0"_disabled\""}' | bash;
rm -rf /Applications/OneDrive.app
echo "please reboot...";
