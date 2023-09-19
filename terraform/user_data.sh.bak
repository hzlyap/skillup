#!/bin/bash -v

sudo perl -pi -e 's/^#?Port 22$/Port 6522/' /etc/ssh/sshd_config
sudo service sshd restart || service ssh restart

sudo aws s3 cp s3://skillup-s3-bucket-hazel.yap-001/index.html /var/www/html/ --region eu-west-1

sudo service apache2 restart
