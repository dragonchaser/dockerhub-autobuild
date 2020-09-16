FROM debian:latest
LABEL maintainer="dragonchaser <crichter@suse.de>"
RUN apt-get update && apt-get install -y python3-pip libopenjp2-7 python3-libtiff
RUN pip3 install matrix-synapse
EXPOSE 8448
EXPOSE 8008
RUN useradd -ms /bin/bash -d /synapse synapse
USER synapse
WORKDIR /synapse
CMD synctl start --no-daemonize
