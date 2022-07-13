FROM debian:latest
LABEL maintainer="dragonchaser <autobuilds@datenschmutz.space>"
RUN apt-get update \
  && apt-get -y install unbound netcat
CMD ["unbound-checkconf", "&&", "unbound -d"]
