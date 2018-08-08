#!/bin/bash
yum update -y
GECKODRIVER_VERSION=v0.21.0
GECKODRIVER_TAR=geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz
XVFB_VERSION=1.19.5
curl -OL http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo
mv epel-apache-maven.repo /etc/yum.repos.d/epel-apache-maven.repo
yum install -y gtk+-devel gtk3-devel apache-maven xorg-x11-server-Xvfb-${XVFB_VERSION} firefox
if ! find /usr/local/bin/geckodriver ; then
   curl -OL https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/${GECKODRIVER_TAR}
   tar -xvf ${GECKODRIVER_TAR}
   rm -f ${GECKODRIVER_TAR}
   sudo mv geckodriver /usr/local/bin/geckodriver
fi   

