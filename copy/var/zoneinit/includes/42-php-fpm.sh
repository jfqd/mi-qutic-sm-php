#!/usr/bin/env bash

# Configure PHP sendmail return-path if possible
if mdata-get kumquat_admin_email 1>/dev/null 2>&1; then
  echo "php_admin_value[sendmail_path] = /usr/sbin/sendmail -t -i -f $(mdata-get kumquat_admin_email)" \
    >> /opt/local/etc/php/8.3/php-fpm.d/www.conf
fi

# Enable PHP-FPM
/usr/sbin/svcadm enable svc:/pkgsrc/php-fpm83:default

echo "* Fix logadm.conf"
sed -i \
    -e "s#-C -c -s 50m -z 1 5##" \
    -e "s#/var/log/php-fpm.log#/var/log/php-fpm83.log#" \
    /etc/logadm.conf

echo "/opt/local/bin/sed -i \"s#/var/log/php-fpm.log.*##\" /etc/logadm.conf" >> /opt/local/bin/uptodate
