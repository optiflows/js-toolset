FROM alpine:3.8

ENV WORKSPACE /home

COPY settings/repositories /etc/apk/repositories
# Installing build tools
RUN apk --update add \
    bash \
    tar \
    git \
    nodejs \
    npm \
    jq \
    curl

# Installing the JS toolchain
RUN npm install -g @angular/cli

WORKDIR ${WORKSPACE}