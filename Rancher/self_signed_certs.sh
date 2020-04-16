#!/bin/bash
DOMAIN=$1
docker run -v $PWD/certs:/certs -e SSL_SUBJECT=${DOMAIN} -e SSL_DNS=${DOMAIN} -e CA_SUBJECT=${DOMAIN} superseb/omgwtfssl
