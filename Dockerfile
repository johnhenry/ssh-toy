FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git vim openssh-server sudo nginx -y
COPY ./nginx.conf /etc/nginx/sites-available/default
RUN useradd -rm --home /git -s /bin/bash -g www-data -u 1000 git
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
RUN passwd -d git
RUN mkdir /run/sshd
RUN mkdir /deployed /www
RUN chown -R git:www-data /deployed /www
USER git
RUN ln -s /www /git/www
RUN ln -s /deployed /git/deployed
RUN git init --bare /www --initial-branch=main
RUN cd /www && git config receive.denyCurrentBranch updateInstead
COPY ./post-receive.sh /www/hooks/post-receive
USER root
RUN chmod +x /www/hooks/post-receive
ENTRYPOINT /usr/sbin/sshd && nginx -g 'daemon off;'
