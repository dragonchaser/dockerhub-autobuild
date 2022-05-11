def main(ctx):
    return [
        stepPR("amd64"),
        stepPR("arm64"),
        stepMergeMaster("amd64"),
        stepMergeMaster("arm64"),
    ]


def stepPR(arch):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "docker-build-%s" % (arch),
        "platform": {
            "os": "linux",
            "arch": arch,
        },
        "steps": [
            {
                "name": "build-image-%s" % (arch),
                "image": "plugins/docker",
                "settings": {
                    "dockerfile": "motsognir/Dockerfile",
                    "repo": "dragonchaser/motsognir",
                    "dry_run": "true",
                    "tag": "latest-%s" % (arch),
                    "username": {
                        "from_secret": "dockerhub-user"
                    },
                    "password": {
                        "from_secret": "dockerhub-password"
                    }
                }
            },
        ],
        "trigger": {
            "ref": [
                "refs/pull/**",
            ],
        },
    }

def stepMergeMaster(arch):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "docker-publish-%s" % (arch),
        "platform": {
            "os": "linux",
            "arch": arch,
        },
        "steps": [
            {
                "name": "build-build-and-publish-image-%s" % (arch),
                "image": "plugins/docker",
                "settings": {
                    "dockerfile": "motsognir/Dockerfile",
                    "repo": "dragonchaser/motsognir",
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
        ],
        "trigger": {
            "ref": [
                "refs/heads/master",
            ],
        },
    }
