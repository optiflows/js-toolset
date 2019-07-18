# js-toolset

[![CircleCI](https://circleci.com/gh/surycat/js-toolset.svg?style=svg)](https://circleci.com/gh/surycat/js-toolset)
[![Docker Hub](https://img.shields.io/docker/pulls/surycat/js-toolset.svg)](https://hub.docker.com/r/surycat/js-toolset)

[Alpine](https://hub.docker.com/_/alpine/) based container that provides useful tools when writing JS applications.

```bash
docker pull optiflows/js-toolset
```

## Permissions

The user `devuser` has sudoer permissions. Its `$HOME` path is `/home/devuser`.
A Docker environment variable `WORKSPACE` point to this very folder, and it shall be used to store your app sources.

## Embedded tools

* node
* npm
* yarn
* bower
* gulp
* yo
* chromium (through xvfb)
* sass
