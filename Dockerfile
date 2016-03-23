FROM ubuntu:14.04.4
MAINTAINER k_tei@geishatokyo.com

# Install and configure a basic SSH server
RUN apt-get update &&\
    apt-get install -y openssh-server &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get update &&\
    apt-get install -y openjdk-7-jdk &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install JDK 7 (latest edition)
RUN apt-get update &&\
    apt-get install -y wget git curl zip && rm -rf /var/lib/apt/lists/*

# Install gcc
RUN apt-get update &&\
    apt-get install -y autoconf bison build-essential libssl-dev \
    libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev \
    libgdbm3 libgdbm-dev libmysqld-dev && rm -rf /var/lib/apt/lists/*

# Set user jenkins to the image
RUN adduser --quiet jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
