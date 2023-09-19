#!/bin/bash -v

#sudo perl -pi -e 's/^#?Port 22$/Port 6522/' /etc/ssh/sshd_config
#sudo service sshd restart || service ssh restart

#sudo aws s3 cp s3://skillup-s3-bucket-hazel.yap-001/index.html /var/www/html/ --region eu-west-1

#sudo service apache2 restart

sudo apt-get update
sudo apt-get install -y awscli git cloud-utils ansible python3-boto3 python3-botocore

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get install -y ansible


