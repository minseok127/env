FROM ubuntu:oracular

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN apt-get update -y && apt-get upgrade -y

RUN apt-get -y install vim git sudo wget build-essential
RUN apt-get -y install pkgconf bison libreadline-dev zlib1g-dev flex libicu-dev cmake tree
RUN apt-get -y install libtool libpq-dev autoconf curl

RUN apt-get -y install net-tools openssh-server

RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/run/sshd

RUN getent group ubuntu || groupadd --gid 1000 ubuntu \
	&& id -u ubuntu || useradd --uid 1000 --gid 1000 -m ubuntu \
	&& echo "ubuntu ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
	&& chmod 0440 /etc/sudoers.d/ubuntu

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN echo "service ssh start" >> /root/.bashrc

USER ubuntu

