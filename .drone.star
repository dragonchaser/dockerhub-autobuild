def main(ctx):
    return [
        stepPR("amd64", "motsognir"),
        stepPR("arm64", "motsognir"),
        stepMergeMaster("amd64", "motsognir"),
        stepMergeMaster("arm64", "motsognir"),
        stepBuildWeekly("amd64", "motsognir"),
        stepBuildWeekly("arm64", "motsognir"),

        stepPR("amd64", "webtest"),
        stepPR("arm64", "webtest"),
        stepMergeMaster("amd64", "webtest"),
        stepMergeMaster("arm64", "webtest"),
        stepBuildWeekly("amd64", "webtest"),
        stepBuildWeekly("arm64", "webtest"),
    ]


def stepPR(arch, path):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "docker-build-%s-%s" % (path, arch),
        "platform": {
            "os": "linux",
            "arch": arch,
        },
        "steps": [
            {
                "name": "build-image-%s-%s" % (path, arch),
                "image": "plugins/docker",
                "settings": {
                    "dockerfile": "%s/Dockerfile" % (path),
                    "repo": "dragonchaser/%s" % (path),
                    "dry_run": "true",
                    "tag": "latest-%s" % (arch),
                }
            },
            {
              "name": "notify-build-%s-%s" % (path, arch),
              "image": "plugins/matrix",
              "settings": {
                "homeserver": {
                  "from_secret": "matrix-homeserver"
                },
                "roomid": {
                  "from_secret": "matrix-room"
                },
                "username": {
                  "from_secret": "matrix-user"
                },
                "password": {
                  "from_secret": "matrix-password"
                }
              }
            },
        ],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
            "status": [
              "success",
              "failure"
            ]
        },
    }

def stepMergeMaster(arch, path):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "docker-publish-%s-%s" % (path, arch),
        "platform": {
            "os": "linux",
            "arch": arch,
        },
        "steps": [
            {
                "name": "build-and-publish-image-%s-%s" % (path, arch),
                "image": "plugins/docker",
                "settings": {
                    "dockerfile": "%s/Dockerfile" % (path),
                    "repo": "dragonchaser/%s" % (path),
                    "dry_run": "false",
                    "tag": "latest-%s" % (arch),
                    "username": {
                        "from_secret": "dockerhub-user"
                    },
                    "password": {
                        "from_secret": "dockerhub-password"
                    }
                }
            },
            {
              "name": "notify-publish-%s-%s" % (path, arch),
              "image": "plugins/matrix",
              "settings": {
                "homeserver": {
                  "from_secret": "matrix-homeserver"
                },
                "roomid": {
                  "from_secret": "matrix-room"
                },
                "username": {
                  "from_secret": "matrix-user"
                },
                "password": {
                  "from_secret": "matrix-password"
                }
              }
            },
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
            ],
            "status": [
              "success",
              "failure"
            ]
    }
  }

def stepBuildWeekly(arch, path):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "docker-publish-weekly-%s-%s" % (path, arch),
        "platform": {
            "os": "linux",
            "arch": arch,
        },
        "steps": [
            {
                "name": "build-and-publish-image-%s-%s" % (path, arch),
                "image": "plugins/docker",
                "settings": {
                    "dockerfile": "%s/Dockerfile" % (path),
                    "repo": "dragonchaser/%s" % (path),
                    "dry_run": "false",
                    "tag": "latest-%s" % (arch),
                    "username": {
                        "from_secret": "dockerhub-user"
                    },
                    "password": {
                        "from_secret": "dockerhub-password"
                    }
                }
            },
            {
              "name": "notify-publish-%s-%s" % (path, arch),
              "image": "plugins/matrix",
              "settings": {
                "homeserver": {
                  "from_secret": "matrix-homeserver"
                },
                "roomid": {
                  "from_secret": "matrix-room"
                },
                "username": {
                  "from_secret": "matrix-user"
                },
                "password": {
                  "from_secret": "matrix-password"
                }
              }
            },
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
            ],
            "event": [
              "cron"
            ],
            "cron": [
              "weekly"
            ]
        },
    }