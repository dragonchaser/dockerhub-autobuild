# unbound

A container for unbound https://github.com/NLnetLabs/unbound

## Running locally

**amd64**

```
$> docker run \
    -p 53:53 \
    -v /path/to/you/local/unboundfolder/conf:/etc/unbound \
    -v /path/to/you/local/unboundfolder/lib:/var/lib/unbound \
    dragonchaser/unbound:latest-amd64 
```

**arm64**

```
$> docker run \
    -p 53:53 \
    -v /path/to/you/local/unboundfolder/conf:/etc/unbound \
    -v /path/to/you/local/unboundfolder/lib:/var/lib/unbound \
    dragonchaser/unbound:latest-arm64 
```

