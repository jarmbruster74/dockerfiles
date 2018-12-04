#!/usr/bin/env bash

saml2aws configure --idp-provider=ADFS --mfa=Auto --url=https://adfs.intelematics.com/adfs/ls/idpinitiatedsignon.aspx --username="$USERNAME" --skip-prompt
saml2aws login --profile=default --password="$PASS" --role=arn:aws:iam::"$ACCOUNT":role/ADFS-Administrator --skip-prompt

terraform init \
	-backend-config "bucket=$STATE_BUCKET" \
	-backend-config "region=$STATE_BUCKET_REGION" \
	-from-module /usr/src \
	-get-plugins=false

terraform "$@"