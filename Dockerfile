FROM ubuntu:25.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        curl \
        dnsutils \
        iproute2 \
        iputils-ping \
        iputils-tracepath \
        less \
        mtr \
        nano \
        net-tools \
        netcat-openbsd \
        nmap \
        openssh-client \
        tcpdump \
        traceroute \
        wget && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s `which python3` /usr/bin/python

COPY ./templates/.bash_aliases ./templates/.bashrc /root/
