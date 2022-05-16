# motsognir

A container for the motsognir gopher server http://motsognir.sourceforge.net/

## Running locally

**amd64**

```
$> docker run -p 70:70 -v /path/to/you/local/gopherfolder:/gopher dragonchaser/motsognir:latest-amd64 
```

**arm64**

```
$> docker run -p 70:70 -v /path/to/you/local/gopherfolder:/gopher dragonchaser/motsognir:latest-arm64
```

**Notes:** 
- `motsognir.conf` needs to live in `/gopher`
- I suggest serving files from a subdirectory of `/gopher`
- I suggest also to use the `gopher` user in the `RunAsUser` variable in `/gopher/motsognir.conf`
- the container uses a bare minimal of an operating system needed to run
  motsognir, for debugging it might make sense to run `apt-get install procps`
  in the container
