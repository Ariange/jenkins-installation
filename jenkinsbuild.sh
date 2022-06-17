#!/bin/bash

#Author: Edem, June 13 2022

sudo yum install java-1.8.0-openjdk-devel -y

# Enable the Jenkins repository

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

Install the latest stable version of Jenkins

sudo yum install jenkins -y

# Start the Jenkins service#
 sudo systemctl start jenkins

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

sudo firewall-cmd --reload

sudo yum install java-1.8.0-openjdk-devel -y

# Enable the Jenkins repository

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo


sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo

Install the latest stable version of Jenkins

sudo yum install jenkins -y

# Start the Jenkins service#
 sudo systemctl start jenkins

## Script to open necessary port for Jenkins

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

sudo firewall-cmd --reload

## Setting up Jenkins in the browser
  # install utilities to display web page
    sudo yum install curl wget lynx w3m elinks -y

   # Provide Initial Admin Password to user
     echo "Copy Password to login as Admin to Jenkins page"
       sudo cat /var/lib/jenkins/secrets/initialAdminPassword
          sleep 30

   # opening Jenkins page from the browser

   elinks  http://192.168.56.32:8080
