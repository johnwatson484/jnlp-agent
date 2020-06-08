# Set default values for build arguments
ARG DOCKERFILE_VERSION=1.0.0
ARG JNLP_VERSION=3.27-1

FROM jenkins/jnlp-slave:$JNLP_VERSION-alpine

# Label images to aid searching
LABEL jnlp.version=$JNLP_VERSION \
      version=$DOCKERFILE_VERSION \
      repository=johnwatson484/jnlp-slave

USER root
RUN apk add --no-cache docker curl jq

USER jenkins

ENTRYPOINT ["jenkins-slave"]
