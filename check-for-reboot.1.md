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

# EXAMPLES

Here's the typical use case

    sudo apt update;sudo apt upgrade
    sudo apt autoremove; sudo apt autoclean
    check-for-reboot.bash

