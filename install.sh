#!/bin/bash

yum update -y

curl -L http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo > /etc/yum.repos.d/epel-apache-maven.repo 

yum install -y gtk3-devel apache-maven xorg-x11-server-Xvfb firefox

if ! find /usr/local/bin/geckodriver ; then
   GECKODRIVER_TAR="geckodriver-v0.21.0-linux64.tar.gz"
   curl -L https://github.com/mozilla/geckodriver/releases/download/v0.21.0/${GECKODRIVER_TAR} | tar xvfz - -C /usr/local/bin/
   # tar -xvf ${GECKODRIVER_TAR}
   # rm -f ${GECKODRIVER_TAR}
   # mv geckodriver /usr/local/bin/geckodriver
fi   

