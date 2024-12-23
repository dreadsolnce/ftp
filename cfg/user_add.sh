#!/bin/bash
massiv=${USERS}
count_id=2048

for i in ${massiv[@]}; do
  name_user="${i%%:*}"
  echo "Настраиваем пользователя: "${name_user}" с id номером:"${count_id}
  pass_user="${i##*:}"
  groupadd -g ${count_id} ${name_user}
  useradd -u ${count_id} -ms /bin/bash -g ${name_user} -p "$(openssl passwd -1 ${pass_user})" ${name_user}
  count_id=$(( $count_id + 1 ))
  echo ${name_user} >> /etc/ftpuser.lst
  mkdir -p /data/${name_user}
  chown -R ${name_user}:${name_user} /data/${name_user}
done

sed -i "s/^pasv_address.*/pasv_address=`echo ${IP_CURRENT_HOST}`/" /etc/vsftpd.conf
sed -i "s/^xferlog_enable.*/xferlog_enable=`echo ${LOGING_VSFTPD}`/" /etc/vsftpd.conf
sed -i "s/^pasv_min_port.*/pasv_min_port=`echo ${PASV_MIN_PORT}`/" /etc/vsftpd.conf
sed -i "s/^pasv_max_port.*/pasv_max_port=`echo ${PASV_MAX_PORT}`/" /etc/vsftpd.conf
sed -i "s/^pasv_enable.*/pasv_enable=`echo ${PASV_ENABLE}`/" /etc/vsftpd.conf


exit 0
