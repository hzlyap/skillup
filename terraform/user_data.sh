#!/bin/bash -v

# TF skillup
#sudo perl -pi -e 's/^#?Port 22$/Port 6522/' /etc/ssh/sshd_config
#sudo service sshd restart || service ssh restart

#sudo aws s3 cp s3://skillup-s3-bucket-hazel.yap-001/index.html /var/www/html/ --region eu-west-1

#sudo service apache2 restart
# END TF


# Ansible skillup
sudo apt-get update
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get install -y ansible awscli python3-boto3 python3-botocore

git clone https://github.com/hzlyap/skillup.git
cd skillup
git checkout ansible

instance_id=$(ec2metadata --instance-id)
ec2_role=$(aws ec2 describe-instances --region us-east-2 --instance-id $instance_id --output text --query 'Reservations[].Instances[].Tags[?Key==`ansible_role`].Value')

private_ip_address=$(aws ec2 describe-instances --region us-east-2 --instance-id $instance_id --output text --query 'Reservations[].Instances[].[PrivateIpAddress]')

ansible-playbook ansible/frontend.yml --extra-vars "ansible_role=$ec2_role private_ip_address=$private_ip_address"
# END ANSIBLE
