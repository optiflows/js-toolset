FROM alpine:3.3

ENV WORKSPACE /home/devuser
ENV CHROME_BIN /usr/bin/xvfb-chromium
ENV SKIP_SASS_BINARY_DOWNLOAD_FOR_CI true
ENV SASS_BINARY_PATH=/usr/lib/node_modules/node-sass/vendor/linux-x64-46/binding.node

COPY settings/repositories /etc/apk/repositories
# Installing build tools, chromium and an X server
RUN apk --update add \
    bash \
    vim \
    tar \
    git \
    dpkg \
    python \
    make \
    g++ \
    openssh-client \
    xvfb \
    chromium \
    libexif \
    udev \
    nodejs

# Patching the launch command to goes through xvfb
COPY settings/xvfb-chromium.sh /usr/bin/xvfb-chromium
RUN chmod 755 /usr/bin/xvfb-chromium
RUN ln -fs /usr/bin/chromium-browser /usr/bin/chromium

RUN addgroup staff
RUN adduser -D -g "" -G staff -s /bin/bash devuser
RUN echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN touch ${WORKSPACE}/.bashrc
RUN chown -R devuser:staff ${WORKSPACE}

# Installing the JS toolchain
RUN npm install -g bower
RUN npm install -g gulp
RUN npm install -g yo
RUN npm install -g node-sass

USER devuser
WORKDIR ${WORKSPACE}

# Installing Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
