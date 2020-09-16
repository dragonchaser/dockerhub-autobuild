# dockerhub-autobuild

This repo contains Dockerfiles used for autobuilding on Dockerhub.
No guarantee for completeness or functionality.

|URL|Folder|Description|x86_64|arm32v7|
|:--|:-----|:----------|:----:|:-----:|
|[dragonchaser/webtest](https://hub.docker.com/r/dragonchaser/webtest)|webtest|A small container running ruby WebRick and serves static content from /web|x|x|
|[dragonchaser/nginx-matrix](https://hub.docker.com/r/dragonchaser/nginx-matrix)|nginx-matrix|A modification of the nginx:latest image that exposes tcp ports 80,443 and 8448 for use as reverse proxy with a matrix server (e.g. synapse)|x|x|
|[dragonchaser/matrix-synapse](https://hub.docker.com/r/dragonchaser/matrix-synapse)|matrix-synapse|**WIP** A container running the matrix reference server synapse|x|x|
