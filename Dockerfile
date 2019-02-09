FROM nginx:latest

RUN apt-get update
RUN apt-get install -y vim wget software-properties-common

WORKDIR /root

RUN wget https://dl.eff.org/certbot-auto
RUN chmod a+x certbot-auto

RUN unlink /var/log/nginx/access.log && \
    unlink /var/log/nginx/error.log
