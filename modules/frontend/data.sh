#!/bin/bash
# Install Apache Web Server and PHP
echo "******** Installing  Apache 2 ********"
sudo yum update -y
sudo yum install -y httpd 
sudo yum install -y php
sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y mysql-community-server 

# PDO driver installed for php
sudo yum -y install php-pdo php-mysqlnd

# installing git 
#sudo yum install git

# Installing Jenkins server and java 
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install java -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins




# Turn on web server and mysql
sudo chkconfig httpd on
sudo service httpd start
sudo systemctl enable mysqld
sudo systemctl start  mysqld

echo "******** Completed Installation ********"
