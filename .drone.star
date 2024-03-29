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

        stepPR("amd64", "unbound"),
        stepPR("arm64", "unbound"),
        stepMergeMaster("amd64", "unbound"),
        stepMergeMaster("arm64", "unbound"),
        stepBuildWeekly("amd64", "unbound"),
        stepBuildWeekly("arm64", "unbound"),
        
        notify(ctx),
    ]

def notify(ctx):
  return {
        "kind": "pipeline",
        "type": "docker",
        "name": "matrix-notifications",
        "clone": {
            "disable": True,
        },
        "steps": [
          {
              "name": "notify",
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
        "depends_on": [ 
                        "docker-build-motsognir-amd64", 
                        "docker-build-motsognir-arm64", 
                        "docker-build-webtest-amd64",
                        "docker-build-webtest-arm64",                  
                        "docker-build-unbound-amd64",
                        "docker-build-unbound-arm64",                  

                        "docker-publish-motsognir-amd64", 
                        "docker-publish-motsognir-arm64", 
                        "docker-publish-webtest-amd64",
                        "docker-publish-webtest-arm64",                  
                        "docker-publish-unbound-amd64",
                        "docker-publish-unbound-arm64",                  

                        "docker-publish-weekly-motsognir-amd64", 
                        "docker-publish-weekly-motsognir-arm64", 
                        "docker-publish-weekly-webtest-amd64",
                        "docker-publish-weekly-webtest-arm64",                  
                        "docker-publish-weekly-unbound-amd64",
                        "docker-publish-weekly-unbound-arm64",                  
                      ],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/heads/release*",
                "refs/tags/**",
                "refs/pull/**",
            ],
            "status": [
                "failure",
                "success",
            ],
        },
      }

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