FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git vim openssh-server sudo nginx fcgiwrap spawn-fcgi rsync -y
COPY nginx.conf /etc/nginx/nginx.conf
RUN useradd -rm --home /git -s /bin/bash -g www-data -u 1000 git
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