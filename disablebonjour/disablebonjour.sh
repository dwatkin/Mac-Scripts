#!/bin/bash
#############################################
# AUTHOR: JONATHAN SCHWENN @JONSCHWENN      #
# MAC MINI VAULT - MAC MINI COLOCATION      #
# MACMINIVAULT.COM - @MACMINIVAULT          #
# VERSION 2.0  RELEASE DATE OCT 1 2014      #
# DESC:  DISABLES BONJOUR ADVERTISING       #
#############################################
#REQUIREMENTS:
#  OS X 10.6 or newer
#############################################

if [[  $(sw_vers) ]]
then
	# MAKES SURE WE ARE RUNNING 10.6 -> 10.9 
	if [[  $(sw_vers -productVersion | grep '10.[6-9]') ]]
	then
		# CHECKS FOR FLAG IN CURRENT PLIST FILE
		if [[ $(sudo /usr/libexec/PlistBuddy -c Print /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist | grep 'NoMulticast') ]]
		then
			echo "MULTICAST DISABLED, NO CHANGES MADE"
		else
			sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments: string -NoMulticastAdvertisements" /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
			sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
 			sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
			echo "MULTICAST DISABLED (OS X 10.6-10.9)"
		fi
		exit
	else
	echo  "OS X 10.6 - 10.9 NOT DETECTED, NO CHANGES HAVE BEEN MADE" 
	echo  "CHECKING FOR OS X 10.10..."
		if [[  $(sw_vers -productVersion | grep '10.10') ]]
        	then
                	# CHECKS FOR FLAG IN CURRENT PLIST FILE
			if [[ $(sudo /usr/libexec/PlistBuddy -c Print /System/Library/LaunchDaemons/com.apple.discoveryd.plist | grep 'no-multicast') ]]
	                then	
				echo "MULTICAST DISABLED, NO CHANGES MADE"
                	else
                        	sudo /usr/libexec/PlistBuddy -c "Add :ProgramArguments: string --no-multicast" /System/Library/LaunchDaemons/com.apple.discoveryd.plist
                        	sudo launchctl unload /System/Library/LaunchDaemons/com.apple.discoveryd.plist
				sudo launchctl load /System/Library/LaunchDaemons/com.apple.discoveryd.plist
                        	echo "MULTICAST DISABLED (OSX 10.10)"
                	fi
                	exit
		else
		echo "OS X 10.10 NOT DETECTED, NO CHANGES HAVE BEEN MADE"	
		fi
	fi

else
echo "SORRY, OS X NOT DETECTED - NO CHANGES MADE"
fi
exit
