#!/bin/bash

if [ -f /coda/eprints-3.3/var/indexer.pid ]; then
	cat  <<EOT
The file /coda/eprints-3.3/var/indexer.pid exists.

The EPrints indexer appears to be running. This should be
stopped before rebooting. Do the following.

    cd /coda/eprints-3.3
    sudo su
    su eprints
    ./bin/indexer stop
    exit
    exit

EOT
	exit 1
fi

RESULT=$( ps -ef | grep indexer | grep -v 'grep')
if [ "$RESULT" != "" ]; then
	cat <<EOT
Checked the processes table, found

   $RESULT

The EPrints indexer appears to be running. This should be
stopped before rebooting. Do the following.

    cd /coda/eprints-3.3
    sudo su
    su eprints
    ./bin/indexer stop
    exit
    exit

EOT
	exit 1
fi
