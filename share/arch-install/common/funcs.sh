#########################################
# Christian's ArchLinux Install Scripts #
#  --updated 1.10.2022                  #
#########################################
#!/bin/bash
# ~/arch-install/common/funcs.sh
#
# helper functions 
# sourced from:
#  install.sh
#  new-root.sh
#  user-me.sh
#

### Functions

die () {
	process="$1"
	[[ -z $process ]] && process="Uknown"
	printf '\n    %s ................................... [ FATAL ]\n\n' "$process"
	sleep 2
	exit 1 
}

kill_now () {
	[[ $? -eq * ]] && exit 1
	exit 1
}

success () {
	process="$1"
	[[ -z $process ]] && process="Uknown"
	printf '\n    %s ................................... [ OK ]\n\n' "$process"
	sleep 1
	return 0
}

next () {
	[[ $? -eq 0 ]] && return 0
	exit 1
}

outcome () {
	status="$1"
	process="$2"

	if [ "$status" -eq 0 ]; then
		success "$process"
		return 0
	else
		die "$process"
		kill_now
	fi
	return 0
}

