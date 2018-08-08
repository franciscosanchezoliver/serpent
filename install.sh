#!/bin/bash

#**** GECKODRIVER ****
GECKODRIVER_VERSION=v0.21.0
GECKODRIVER_TAR=geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz

#**** XVFB ****
XVFB_VERSION=1.19.5

INSTALL="yum install -y"

#Stop script on first error
set -e

waitForKeyPress()
{
   if $DEBUG ; then  
      read -p "Press enter to continue"
   fi
}

DEBUG=false

if [ $# -gt 0 ]; then
   if [ $1 = "-d" ] || [ $1 = "--debug" ] ; then
      DEBUG=true
   fi
fi

yum update -y

$INSTALL gtk+-devel gtk3-devel
waitForKeyPress

# MAVEN
curl -OL http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo
mv epel-apache-maven.repo /etc/yum.repos.d/epel-apache-maven.repo
$INSTALL apache-maven

waitForKeyPress

# INSTALLING Xvfb
$INSTALL xorg-x11-server-Xvfb-${XVFB_VERSION}
waitForKeyPress

# INSTALLING GECKODRIVER
if ! find /usr/local/bin/geckodriver ; then
   curl -OL https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/${GECKODRIVER_TAR}
   tar -xvf ${GECKODRIVER_TAR}
   rm -f ${GECKODRIVER_TAR}
   sudo mv geckodriver /usr/local/bin/geckodriver
fi   

waitForKeyPress

# INSTALLING FIREFOX
$INSTALL firefox

