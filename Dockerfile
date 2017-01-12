FROM alpine:3.5

ENV SKIP_SASS_BINARY_DOWNLOAD_FOR_CI true
ENV SASS_BINARY_PATH=/usr/lib/node_modules/node-sass/vendor/linux-x64-46/binding.node
ENV PATH $PATH:/root/.yarn/bin
ENV WORKSPACE /home/

RUN set -ex  && \
    # Install dependencies
    apk add --update --no-cache bash vim git nodejs  && \
    apk add --no-cache --virtual build-deps curl build-base python2  && \
    curl -o- -L https://yarnpkg.com/install.sh | bash  && \
    /root/.yarn/bin/yarn global add bower gulp node-sass  && \
    # Allow bower in root
    echo '{"allow_root": true}' > /root/.bowerrc  && \
    # Clean build dependencies
    apk del build-deps  && \
    rm -rf /tmp/* /var/cache/apk/*

WORKDIR ${WORKSPACE}
