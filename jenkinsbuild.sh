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
    
   # Provide Initial Admin Password to user

     echo "Copy below password to login as Admin on the Jenkins page"
       sudo cat /var/lib/jenkins/secrets/initialAdminPassword
       if 
         [ $? -ne 0 ]
          then
             echo " Display of the password failed "
             exit 9
          else
             sleep 5

             echo "Do you want to display the page in the command line? (Yes/No)"
             read Answer
               if [ $Answer = Yes ]
                 then
                       elinks  http://192.168.56.32:8080
                       if 
                           [ $? -ne 0 ]
                           then
                               echo " Opening browser in the command line failed "
                               exit 10 
                        fi
                  else
                        if [ $Answer = No ]
                         
                         then 
                             echo " Click on http://192.168.56.32:8080 to navigate to Jenkins page "  

                          else
                             echo " Invalid Entry, enter Yes or No"
                             exit 11
                      fi                
                fi
       fi
          

  
