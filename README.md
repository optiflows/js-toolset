# js-toolset

[![CircleCI](https://circleci.com/gh/surycat/js-toolset.svg?style=svg)](https://circleci.com/gh/surycat/js-toolset)
[![Docker Hub](https://img.shields.io/docker/pulls/surycat/js-toolset.svg)](https://hub.docker.com/r/surycat/js-toolset)

## Build environment

This container is to be used within an angular app folder.

Two ONBUILD commands will install all dependencies for this specific app and the run the angular dev server.

```dockerfile
FROM surycat/js-toolset:ng
```
