FROM alpine:3.5

ENV WORKSPACE /home/devuser
ENV CHROME_BIN /usr/bin/xvfb-chromium
ENV SKIP_SASS_BINARY_DOWNLOAD_FOR_CI true
ENV SASS_BINARY_PATH=/usr/lib/node_modules/node-sass/vendor/linux-x64-46/binding.node
ENV PATH $PATH:/home/devuser/.yarn/bin

#COPY settings/repositories /etc/apk/repositories

# Installing build tools, chromium and an X server
RUN apk --update add \
    bash \
    curl \
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
    nodejs \
# protractor package
    supervisor \
    openjdk8

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
RUN npm install -g node-sass


# Install Protractor, Selenium and Chrome driver
RUN npm install -g protractor@4.0.x
RUN webdriver-manager update

USER devuser
WORKDIR ${WORKSPACE}

# Installing Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# By default, tests in /data directory will be executed once and then the container
# will quit. When MANUAL envorinment variable is set when starting the container,
# tests will NOT be executed and Xvfb and Selenium will keep running.
#ADD bin/run-protractor /usr/local/bin/run-protractor


# Add main configuration file
ADD settings/supervisor.conf /etc/supervisor/supervisor.conf
# Add service defintions for Xvfb, Selenium and Protractor runner
ADD settings/supervisord/*.conf /etc/supervisor/conf.d/