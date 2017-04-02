#
# dagar base environment
#

FROM ubuntu:xenial
MAINTAINER Daniel Agar <daniel@agar.ca>

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get -y --quiet --no-install-recommends install \
		bzip2 \
		ca-certificates \
		fdupes \
		findimagedupes \
		git \
		gnupg-agent \
		gosu \
		jhead \
		mosh \
		openssh-server \
		rsync \
		ssh \
		sudo \
		tmux \
		unison \
		unison-gtk \
		unzip \
		vim \
		wget \
		zip \
		zsh \
	&& apt-get -y autoremove \
	&& apt-get clean autoclean \
	# cleanup
	&& rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

ENV DISPLAY :0
ENV TERM=xterm

# ssh server
RUN mkdir -p /var/run/sshd
RUN sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
RUN sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
#RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
#RUN echo root:root | chpasswd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

RUN adduser --disabled-password --gecos '' --uid 1026 --gid 100 dagar
RUN adduser --disabled-password --gecos '' --uid 1027 --gid 100 emily
USER dagar

