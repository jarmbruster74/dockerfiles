#!/usr/bin/env bash

saml2aws configure --idp-provider=Shibboleth --mfa=Auto --url=https://fedauth.colorado.edu --username="$USERNAME" --skip-prompt
saml2aws login --profile=default 

terraform init \
	-backend-config "bucket=$STATE_BUCKET" \
	-backend-config "region=$STATE_BUCKET_REGION" \
	-from-module /usr/src \
	-get-plugins=false

terraform "$@"