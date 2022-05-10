def main(ctx):
  return [
    step("amd64"),
    step("arm64"),
  ]

def step(arch):
  return {
    "kind": "pipeline",
    "name": "build-%s" % arch,
    "steps": [
      {
        "name": "build",
        "image": "plugins/docker",
        "repo": "dragonchaser/motsognir",
        "volumes": [
          {
            "name":"docker_sock",
            "path":"/var/run/docker.sock"
          }
        ],
        "commands": [
          "cd motsognir",
          "docker build -t dragonchaser/motsognir:latest ."
        ]
      }
    ],
    "volumes": [
      {
        "name":"docker_sock",
        "host": {
            "path": "/var/run/docker.sock"
          }
      }
    ]
  }
