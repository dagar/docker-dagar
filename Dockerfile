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
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN adduser --disabled-password --gecos '' --uid 1026 --gid 100 dagar
USER dagar

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

