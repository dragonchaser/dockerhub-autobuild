FROM debian:latest
LABEL maintainer="dragonchaser <crichter@suse.de>"
RUN apt-get update \
	&& apt-get install -y ruby \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /web \
  && chmod 0777 /web
COPY ./entrypoint.sh /bin
COPY ./index.html /web
WORKDIR /web
EXPOSE 80
ENTRYPOINT entrypoint.sh
