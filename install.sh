#!/bin/bash

yum update -y

curl -o /etc/yum.repos.d/epel-apache-maven.repo http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo

yum install -y gtk3-devel apache-maven xorg-x11-server-Xvfb firefox

if ! find /usr/local/bin/geckodriver ; then
   GECKODRIVER_TAR=geckodriver-v0.21.0-linux64.tar.gz
   curl -o ${GECKODRIVER_TAR} https://github.com/mozilla/geckodriver/releases/download/v0.21.0/${GECKODRIVER_TAR}
   tar -xvf ${GECKODRIVER_TAR}
   rm -f ${GECKODRIVER_TAR}
   sudo mv geckodriver /usr/local/bin/geckodriver
fi   

