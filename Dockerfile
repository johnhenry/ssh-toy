FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get -y install docker-ce

RUN apt update && apt install git vim openssh-server sudo nginx fcgiwrap spawn-fcgi rsync -y
RUN curl https://raw.githubusercontent.com/nektos/act/master/install.sh | bash
COPY ./.actrc.large /root/.actrc
COPY nginx.conf /etc/nginx/nginx.conf
RUN useradd -rm --home /git -s /bin/bash -g www-data -u 1000 git
RUN adduser git sudo
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
RUN passwd -d git
RUN mkdir /run/sshd
RUN mkdir /temp /live /.git
RUN chown -R git:www-data /temp /live /.git
USER git
RUN ln -s /.git /git/.git
RUN ln -s /live /git/live
RUN ln -s /temp /git/temp
COPY ./index.html /live/index.html
RUN git init --bare /.git --initial-branch=main
COPY ./post-receive.sh /.git/hooks/post-receive
WORKDIR /.git
RUN git config http.receivepack true
USER root
WORKDIR /
RUN chmod +x /.git/hooks/post-receive
ENTRYPOINT spawn-fcgi -s /run/fcgi.sock /usr/sbin/fcgiwrap && /usr/sbin/sshd && nginx -g 'daemon off;'