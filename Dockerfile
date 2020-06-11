# Set default values for build arguments
ARG DOCKERFILE_VERSION=1.0.0
ARG JNLP_VERSION=3.27-1

FROM jenkins/jnlp-slave:$JNLP_VERSION-alpine

USER root

# Install dependencies as root
RUN apk update && apk add --no-cache docker curl jq make py-pip python-dev libffi-dev openssl-dev gcc libc-dev make && \
    pip install --upgrade pip && \
    pip install cffi && \
    pip install docker-compose

## Helm
RUN apk add --update --no-cache curl ca-certificates && \
    curl -L https://get.helm.sh/helm-v3.0.0-linux-amd64.tar.gz |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    apk del curl && \
    rm -f /var/cache/apk/*

## Kubectl
RUN apk add --update --no-cache curl ca-certificates && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl \
    chmod u+x kubectl && mv kubectl /bin/kubectl

USER jenkins

ENTRYPOINT ["jenkins-slave"]
