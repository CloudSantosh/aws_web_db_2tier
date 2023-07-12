# Bootstrap the EC2 instance provides a shell script that will be executed when the instance starts  
# updates the package manager, installs Java Development Kit (JDK) 8, 
# downloads and installs Jenkins, and starts the Jenkins service.
#apt-get update
#apt-get install -y openjdk-8-jdk

# Download and install Jenkins
#wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
#echo "deb http://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list
#apt-get update
#apt-get install -y jenkins

# Start Jenkins service
#systemctl start jenkins

#!/bin/bash
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo yum install java -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

