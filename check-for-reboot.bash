#!/bin/bash

function usage() {
    APP_NAME="$(basename "$0")"
    cat <<EOT
% ${APP_NAME}(1) user manual
% R. S. Doiel
% 2022-10-19

# NAME

${APP_NAME}

# SYNOPSIS

${APP_NAME}

# DESCRIPTION

This command will check if Ubuntu is expecting to be rebooted.

# EXAMPLES

Here's the typical use case

    sudo apt update;sudo apt upgrade
    sudo apt autoremove; sudo apt autoclean
    ${APP_NAME}

EOT
}

function safe_to_reboot() {
    if command safe_to_reboot.py; then
        safe_to_reboot.py
    fi
    if command safe_to_reboot.bash; then
        safe_to_reboot.bash
    fi
    if [ -d /Sites/ ]; then
        for CHECK_SCRIPT in $(find /Sites -name safe_to_reboot.py); do
            python3 $(CHECK_SCRIPT)
        done
        for CHECK_SCRIPT in $(find /Sites -name safe_to_reboot.bash); do
            python3 $(CHECK_SCRIPT)
        done
    fi
}

#
# Main processing
#
case "$1" in
    -h|-help|--help)
    usage
    exit 0
    ;;
esac
OS=$(uname)
if [ "$OS" != "Linux" ]; then
    echo "This script works goes not work on $OS, aborting"
    exit 1
fi

if [ -e /var/run/reboot-required ]; then
   echo "Reboot required"
   cat /var/run/reboot-required.pkgs
   safe_to_reboot
fi
