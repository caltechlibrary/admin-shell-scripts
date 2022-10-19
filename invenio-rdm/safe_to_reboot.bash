#!/bin/bash

RESULT=$(ps -ef | grep invenio | grep -v 'grep')
if [ "$RESULT" != "" ]; then
	cat <<EOT
Checking the process table returns

   $RESULT

It looks like Invenio-RDM is still running. Follow the steps
to stop Invenio-RDM.

    sudo su ubuntu
    cd /Sites/caltechdata
    sudo systemctl stop nginx
    sudo systemctl stop rdm
    sudo systemctl stop rdm_rest
    sudo systemctl stop rdm_celery
    invenio-cli services stop
    exit

EOT
	exit 1
fi
