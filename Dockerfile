FROM debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade && apt clean

RUN apt install vim vsftpd supervisor net-tools -y

COPY ./cfg/user_add.sh /user_add.sh
COPY ./cfg/vsftpd.conf /etc/vsftpd.conf
COPY ./cfg/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 20 21 20000-20010

ENTRYPOINT [ "/usr/bin/supervisord", "-c",  "/etc/supervisor/conf.d/supervisord.conf"]

