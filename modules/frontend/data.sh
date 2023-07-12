#!/bin/bash
# Install Apache Web Server and PHP
echo "******** Installing  Apache 2 ********"
sudo yum updasudo yum install -y httpd 
sudo yum install -y php
sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y mysql-community-server 


#Download Lab files
#sudo wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1/267-lab-NF-build-vpc-web-server/s3/lab-app.zip
#sudo unzip lab-app.zip -d /var/www/html/

# Turn on web server and mysql
sudo chkconfig httpd on
sudo service httpd start
sudo systemctl enable mysqld
sudo systemctl start  mysqld

echo "******** Completed Installion ********"
