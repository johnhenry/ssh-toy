
FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git vim openssh-server sudo nginx -y
COPY ./nginx.conf /etc/nginx/sites-available/default
RUN useradd -rm --home /deploy -s /bin/bash -g www-data -u 1000 deploy
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
RUN passwd -d deploy
RUN mkdir /run/sshd
WORKDIR /deploy
RUN git init --bare
ENTRYPOINT /usr/sbin/sshd && nginx -g 'daemon off;'
