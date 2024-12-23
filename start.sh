#!/bin/bash
#path=$(cat .env | grep DATA | awk -F= '{print $2}')
docker run --name ftp-server --rm -d --env-file=.env -v ftp_volume:/data -p 20-21:20-21 -p 20000-20010:20000-20010 ftp:latest
