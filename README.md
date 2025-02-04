# Jenkins generic agent

Built on top of the official Jenkins inbound-agent image from [Jenkins docker-agent](https://github.com/jenkinsci/docker-agent/) repository.

This repository contains a Dockerfile to build a generic Jenkins agent to be used for general purpose jobs related to git, docker, and kubernetes.

## Installed packages

- git
- docker
    - docker buildx plugin
- kubectl
- gettext
- jq
