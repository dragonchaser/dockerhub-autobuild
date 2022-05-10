FROM debian:latest
LABEL maintainer="dragonchaser <crichter@suse.de>"
ENV VERSION=1.0.13
ENV TARBALL="motsognir-${VERSION}.tar.xz"
EXPOSE 70
RUN apt-get update \
  && apt-get -y install wget build-essential rsyslog
WORKDIR /build
RUN wget "https://downloads.sourceforge.net/project/motsognir/v${VERSION}/${TARBALL}" \
  && tar xfv "${TARBALL}"
RUN cd $(echo "${TARBALL}" | sed -e "s/.tar.xz//g") && make all && make install
RUN apt-get -y purge wget build-essential
RUN rm -Rfv /etc/apt/sources.list.*
RUN rm -Rfv /build
RUN useradd -ms /bin/bash -d /gopher gopher
WORKDIR /gopher
COPY motsognir/entrypoint.sh /
COPY motsognir/rsyslog.conf /etc
ENTRYPOINT ["/entrypoint.sh"]
