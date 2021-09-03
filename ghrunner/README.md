# GHRUNNER

This is a small Dockerfile providing a github runner.
The images can be found `ghcr.io/dragonchaser/ghrunner:latest`. 
Supported arches are:
  - arm32v7
  - aarch64
  - amd64

## Environment variables

| Variable                                        | Values                                 | default                                                          |
|-------------------------------------------------+----------------------------------------+------------------------------------------------------------------|
| `TOKEN`                                         | token for runner from github           | <unset>                                                          |
| `ARCH`                                          | arm, arm64, x64                        | x64                                                              |
| `OS`                                            | linux,osx                              | linux                                                            |
| `ORG`                                           | name of the github org                 | <unset>                                                          |
| `REPO`                                          | name of the github repo                | <unset>                                                          |
| `VERSION`  version of the github runner to user | 2.280.3                                |                                                                  |
| `CHECKSUM`                                      | checksum for the github runner version | 69dc323312e3c5547ba1e1cc46c127e2ca8ee7d7037e17ee6965ef6dac3c142b |
