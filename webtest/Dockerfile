FROM debian:latest
LABEL maintainer="dragonchaser <autobuilds@datenschmutz.space>"
RUN apt-get update \
	&& apt-get install -y ruby \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /web \
  && chmod 0777 /web
COPY ./webtest/entrypoint.sh /bin
COPY ./webtest/index.html /web
WORKDIR /web
EXPOSE 80
ENTRYPOINT entrypoint.sh
