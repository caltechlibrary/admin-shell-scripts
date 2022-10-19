% check-for-reboot.bash(1) user manual
% R. S. Doiel
% 2022-10-19

# NAME

check-for-reboot.bash

# SYNOPSIS

check-for-reboot.bash

# DESCRIPTION

This command will check if Ubuntu is expecting to be rebooted.
It will display details if a reboot is needed and exit with
a status of 1 otherwise it will not return any output and
exit with a status of 0.

This script will check for "safe_to_reboot.py" and "safe_to_reboot.bash"
in the PATH as well as in /Sites and will run that script to check
if a reboot requires extract steps beyond the usual "sudo reboot"
command.

# EXAMPLES

Here's the typical use case

    sudo apt update;sudo apt upgrade
    sudo apt autoremove; sudo apt autoclean
    check-for-reboot.bash

