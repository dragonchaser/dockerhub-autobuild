def main(ctx):
    return [
        stepPR("amd64", "motsognir"),
        stepPR("arm64", "motsognir"),
        stepMergeMasterAndBuildWeekly("amd64", "motsognir"),
        stepMergeMasterAndBuildWeekly("arm64", "motsognir"),

        stepPR("amd64", "webtest"),
        stepPR("arm64", "webtest"),
        stepMergeMasterAndBuildWeekly("amd64", "webtest"),
        stepMergeMasterAndBuildWeekly("arm64", "webtest"),
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

def stepMergeMasterAndBuildWeekly(arch, path):
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
            ],
            "event": [
              "cron"
            ],
            "cron": [
              "nightly"
            ]
        },
    }
