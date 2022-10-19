#!/bin/bash

# This is just a placeholder until dibs itself has a safe_to_reboot.py script.

if [ -d /Sites/dibs.library.caltech.edu ]; then
    cat <<EOT

DIBS is installed on this machine. You need to log into DIBS and
make sure no loans of materials are active before rebooting this
machine.

EOT

    exit 1
fi
