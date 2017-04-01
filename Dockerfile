#
# dagar base environment
#

FROM ubuntu:xenial
MAINTAINER Daniel Agar <daniel@agar.ca>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get -y --quiet --no-install-recommends install \
		bzip2 \
		ca-certificates \
		git \
		gnupg-agent \
		gosu \
		jhead \
		mosh \
		rsync \
		ssh \
		sudo \
		tmux \
		unison \
		unison-gtk \
		unzip \
		vim
		wget \
		zip \
		zsh
	&& apt-get -y autoremove \
	&& apt-get clean autoclean \
	# cleanup
	&& rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

ENV DISPLAY :0
ENV TERM=xterm

RUN adduser --disabled-password --gecos '' --uid 1026 dagar
USER dagar

CMD ["/bin/bash"]

