FROM ubuntu:25.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
        bash-completion \
        curl \
        dnsutils \
        file \
        inetutils-ftp \
        iproute2 \
        iputils-ping \
        iputils-tracepath \
        jq \
        less \
        mtr \
        nano \
        net-tools \
        netcat-openbsd \
        nmap \
        openssh-client \
        p7zip-full \
        tcpdump \
        traceroute \
        wget \
        zip && \
    rm -rf /var/lib/apt/lists/*

COPY ./templates/.bash_aliases ./templates/.bashrc /root/

RUN ln -s `which python3` /usr/bin/python && \
    cat /etc/profile.d/bash_completion.sh >> ~/.bashrc
