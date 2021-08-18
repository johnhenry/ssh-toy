FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git vim openssh-server sudo nginx rsync -y
COPY ./nginx.conf /etc/nginx/sites-available/default
RUN useradd -rm --home /git -s /bin/bash -g www-data -u 1000 git
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
RUN passwd -d git
RUN mkdir /run/sshd
RUN mkdir /live /www
RUN chown -R git:www-data /live /www
USER git
RUN ln -s /www /git/www
RUN ln -s /live /git/live
RUN git init /www --initial-branch=main
RUN cd /www && git config receive.denyCurrentBranch updateInstead
COPY ./post-receive.sh /www/.git/hooks/post-receive
USER root
RUN chmod +x /www/.git/hooks/post-receive
ENTRYPOINT /usr/sbin/sshd && nginx -g 'daemon off;'
