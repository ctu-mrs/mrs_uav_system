#!/bin/bash
# author: Robert Penicka

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

echo "Installing mrs.felk.cvut.cz certificate in order to enable https requests"
CERT_LOCATION=/tmp/mrs.crt

echo -n | openssl s_client -connect mrs.felk.cvut.cz:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $CERT_LOCATION
sudo cp $CERT_LOCATION /usr/local/share/ca-certificates/
sudo update-ca-certificates
