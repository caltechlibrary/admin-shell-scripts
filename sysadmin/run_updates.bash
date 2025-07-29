#!/bin/bash

APP_NAME="$(basename "$0")"

function helpText() {
	cat <<MSG

# NAME

${APP_NAME}

# SYNOPSIS

${APP_NAME} HOST_NAME

# DESCRIPTION

This script runs the following "apt" actions

- update
- dist-upgrade
- autoremove
- autoclean

It then runs "sudo snap refresh" before calling
"check-for-reboot.bash" on a remote system..

# EXAMPLE

~~~
  ${APP_NAME} apps.library.caltech.edu
~~~

MSG
	exit 0
}

function remoteActions() {
	HOST="$1"
	# Check if the HOST is a full hostname or just a subhost name
    if [[ "$HOST" != *"."* ]]; then
        HOST="${HOST}.library.caltech.edu"
    fi

	for ACTION in "update" "dist-upgrade -y" "autoremove -y" "autoclean"; do
		# shellcheck disable=SC2029
		ssh "${HOST}" "sudo apt-get ${ACTION}"
	done
	ssh "${HOST}" "sudo snap refresh"
	ssh "${HOST}" "check-for-reboot.bash"
}

function localActions() {
	for CMD in "apt-get update" "apt-get dist-upgrade -y" "apt-get autoremove -y" "apt-get autoclean"; do
		# shellcheck disable=SC2086
		sudo ${CMD}
	done
	if command -v snap; then sudo snap refresh; else echo "Skipping snap refresh, not installed"; fi
	if command -v check-for-reboot.bash; then check-for-reboot.bash; else echo "Skipping check-for-reboot.bash, not installed"; fi
}

#
# Main processing
#
case "$1" in
-h | -help | --help | help)
	helpText
	;;
*)
	if [ "$1" = "" ]; then localActions; else remoteActions "$1"; fi
	;;
esac
