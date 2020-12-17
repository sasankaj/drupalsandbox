#!/bin/bash

if [[ -d /var/www/drupal ]]; then  
rsync -a --delete /tmp/drupal/ /var/www/drupal/
fi  

cd /var/www/drupal
composer install

cd /var/www/drupal/web
drush cim -y
drush updb -y
drush cr

# create symlink to server specific settings.php
unlink /var/www/drupal/web/sites/default/settings.php
ln -s /var/www/settings/settings.php /var/www/drupal/web/sites/default/

# create symlink to server specific media files
rm -Rf /var/www/drupal/web/sites/default/files && ln -s /mnt/efs/drupal/files /var/www/drupal/web/sites/default/

#ensure correct ownerships
chown ec2-user:apache -R /var/www/drupal
chown ec2-user:apache -R /var/www/files

#restore file context for selinux
restorecon -R /var/www/drupal
chcon -R -t httpd_sys_content_rw_t /var/www/drupal

#set proper permissions
chmod -R 775 /var/www/drupal
chmod -R 777 /var/www/drupal/web/sites/default/files
chmod -R 777 /var/www/files
chmod -R 755 /var/www/settings
chmod 444 /var/www/drupal/web/sites/default/settings.php
chmod 444 /var/www/settings/settings.local.php
chmod -R 777 /tmp
chmod 0644 /var/www/drupal/web/sites/default/services.yml
chmod 755 /var/www/drupal/web/sites/default
