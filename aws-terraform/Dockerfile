FROM alpine:latest as builder

MAINTAINER Nick Cronin <nick@cronin.id.au>

ENV TERRAFORM_VERSION 0.11.10
ENV SAML2AWS_VERSION 2.11.0
ENV TERRAFORM_AWS_PROVIDER 1.50.0
ENV TERRAFORM_HTTP_PROVIDER 1.0.1

RUN	apk add --no-cache \
	curl \
	ca-certificates \
	unzip

RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN curl -LO https://github.com/Versent/saml2aws/releases/download/v${SAML2AWS_VERSION}/saml2aws_${SAML2AWS_VERSION}_linux_amd64.tar.gz && \
	tar -xvzf saml2aws_${SAML2AWS_VERSION}_linux_amd64.tar.gz

RUN curl -LO https://releases.hashicorp.com/terraform-provider-aws/${TERRAFORM_AWS_PROVIDER}/terraform-provider-aws_${TERRAFORM_AWS_PROVIDER}_linux_amd64.zip && \
	unzip terraform-provider-aws_${TERRAFORM_AWS_PROVIDER}_linux_amd64.zip

RUN curl -LO https://releases.hashicorp.com/terraform-provider-http/${TERRAFORM_HTTP_PROVIDER}/terraform-provider-http_${TERRAFORM_HTTP_PROVIDER}_linux_amd64.zip && \
	unzip terraform-provider-http_${TERRAFORM_HTTP_PROVIDER}_linux_amd64.zip


FROM alpine:latest

RUN apk add --no-cache \
	bash

RUN mkdir -p /root/.terraform.d/plugins

COPY --from=builder /terraform /usr/bin/terraform
COPY --from=builder /saml2aws /usr/bin/saml2aws
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs
COPY --from=builder terraform-provider-*_x4 /root/.terraform.d/plugins/
COPY init.sh /usr/bin/init.sh
RUN mkdir /tf

ENV TF_INPUT=0

WORKDIR /tf

ENTRYPOINT [ "init.sh" ]
CMD [ "--help" ]
