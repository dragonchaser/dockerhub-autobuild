# dockerhub-autobuild

[![Build Status](https://drone.services.datenschmutz.space/api/badges/dragonchaser/dockerhub-autobuild/status.svg)](https://drone.services.datenschmutz.space/dragonchaser/dockerhub-autobuild)

This repo contains Dockerfiles used for autobuilding on Dockerhub.
No guarantee for completeness or functionality.

| URL                                                                       | Folder    | Description                                                                | x86_64 | aarch64 |
| :--                                                                       | :-----    | :----------                                                                | :----: | :-----: |
| [dragonchaser/webtest](https://hub.docker.com/r/dragonchaser/webtest)     | webtest   | A small container running ruby WebRick and serves static content from /web | x      | x       |
| [dragonchaser/motsognir](https://hub.docker.com/r/dragonchaser/motsognir) | motsognir | A container for the motsognir gopher server                                | x      | x       |
| [dragonchaser/unbound](https://hub.docker.com/r/dragonchaser/unbound)     | motsognir | A container for unbound dns                                                | x      | x       |
