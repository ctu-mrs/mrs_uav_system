#!/bin/bash
# author: Robert Penicka

echo "Installing mrs.felk.cvut.cz certificate in order to enable https requests"
CERT_LOCATION=/tmp/mrs.crt

echo -n | openssl s_client -connect mrs.felk.cvut.cz:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $CERT_LOCATION
sudo cp $CERT_LOCATION /usr/local/share/ca-certificates/
sudo update-ca-certificates

exit 0
