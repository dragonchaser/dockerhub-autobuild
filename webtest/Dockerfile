FROM debian:latest
RUN apt-get update \
	&& apt-get install -y ruby
EXPOSE 80
RUN mkdir /web
RUN chmod 0777 /web
WORKDIR /web
COPY ./entrypoint.sh /bin
COPY ./index.html /web
ENTRYPOINT entrypoint.sh
