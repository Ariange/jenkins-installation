#!/bin/bash

#Author: Edem, June 13 2022

# Review Date: June 18, 2020

sudo yum install java-1.8.0-openjdk-devel -y
if
   [ $? -ne 0 ]
   then
   echo " The installation failed, Please try again"
   exit 1
fi

# Enable the Jenkins repository

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
if
   [ $? -ne 0 ]
   then
       sudo yum install wget -yum
       if
        [ $? -ne 0 ]
        then
          echo "The installation failed"
             exit 2
      fi
fi
# Disable key check on the repo
sudo sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
if
   [ $? -ne 0 ]
   then
   echo " The installation failed"
   exit 3
fi

# Install the latest stable version of Jenkins

sudo yum install jenkins -y
if
   [ $? -ne 0 ]
   then
   echo " The installation failed "
   exit 4
fi

# Start the Jenkins service#
 sudo systemctl start jenkins
 if
   [ $? -ne 0 ]
   then
   echo " The installation failed"
   exit 5
fi

#  Open the necessary port for Jenkins

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
if
   [ $? -ne 0 ]
   then
   echo " Opening of port failed"
   exit 6
fi

sudo firewall-cmd --reload
if
   [ $? -ne 0 ]
   then
   echo " Opening of port failed"
   exit 7
fi

## Setting up Jenkins in the browser
  # install utilities to display web page in linux
    sudo yum install elinks -y
 if
   [ $? -ne 0 ]
   then
   echo " browser installation failed"
   exit 8
 fi
             echo " Do you want to display the page in the command line? (Yes/No)"
             read Answer
             var=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
                  if [ $? -ne 0 ]
                     then
                      echo " Command not found "
                        exit 12
                    else
                       echo " Your IP address is $var "

                   if [ $Answer = Yes ]
                       then
                           echo " Copy the following Admin password for later use to access Jenkins for the first time "
                              sudo cat /var/lib/jenkins/secrets/initialAdminPassword
                              if [ $? -ne 0 ]
                                 then
                                     echo "Command not found "
                                  exit 13
                                 else 
                                     elinks  http://$var:8080
                                     if
                                        [ $? -ne 0 ]
                                        then
                                           echo " Opening browser in the command line failed "
                                           exit 10
                                      fi
                              fi        
                  else
                      if [ $Answer = No ]

                         then
                             echo " Launch your browser and navigate to http://$var:8080  to access Jenkins using password: "
                              sudo cat /var/lib/jenkins/secrets/initialAdminPassword
                              if [ $? -ne 0 ]
                                 then
                                     echo "Command not found "
                                  exit 13
                              fi

                          else
                             echo " Invalid Entry, enter Yes or No"
                             exit 11
                      fi
                fi
       fi
