#!/bin/bash
sudo yum update -y
sudo yum install -y docker git
sudo service docker start
sudo usermod -a -G docker ec2-user 
# exec sudo su -l ec2-user 
mkdir -p $HOME/data
export external_ip=$(curl checkip.amazonaws.com)
echo "External IP: ${external_ip}"
sudo -Eu ec2-user bash -c 'docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/data:/data -e CHE_DOCKER_IP_EXTERNAL=${external_ip} eclipse/che start'
# git clone https://github.com/shirkeyaws/aws-config-rdk