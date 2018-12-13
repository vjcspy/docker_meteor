FROM node:8.11.4
MAINTAINER Khoi Le <mr.vjcspy@gmail.com>

# openssh-server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:1' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

CMD ["/usr/sbin/sshd", "-D"]

# Init
ADD init.sh /init.sh
RUN chmod 755 /*.sh

WORKDIR /app

# Volume
VOLUME /app

# Ports: default port meteor 3000
EXPOSE 3000

CMD ["/init.sh"]
