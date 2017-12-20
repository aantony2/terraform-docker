FROM golang:alpine

ENV TERRAFORM_VERSION=0.11.1

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --update \
    git \
    bash \
    openssh \
    python \
    py-pip \
    jq

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

RUN rm /var/cache/apk/*

WORKDIR $GOPATH
