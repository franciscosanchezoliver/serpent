#/bin/bash

#**** SELENIUM ****
SELENIUM_MAJOR_MINOR=2.53
SELENIUM_PATCH=0
SELENIUM_JAR=selenium-server-standalone-${SELENIUM_MAJOR_MINOR}.${SELENIUM_PATCH}.jar

#**** FIREFOX ****
FIREFOX_VERSION=57.0.1
FIREFOX_TAR=firefox-${FIREFOX_VERSION}.tar.bz2

#**** GECKODRIVER ****
GECKODRIVER_VERSION=v0.21.0
GECKODRIVER_TAR=geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz

#**** JAVA ****
JAVA_VERSION=java-1.8.0-openjdk*

#**** MAVEN ****
MAVEN_VERSION=3.0.5
MAVEN_TAR="apache-maven-${MAVEN_VERSION}-bin.tar.gz"

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

# INSTALLING DEPENDENCIES FOR THE INSTALLATION PROCESS
echo "Installing wget"
$INSTALL wget
echo "[ OK ] wget installed"

echo "Installing bzip2"
$INSTALL bzip2
echo "[ OK ] bxip2 installed"

echo "Installing gtk3"
$INSTALL gtk+-devel gtk3-devel
echo "[ OK ] gtk3 installed"

# INSTALLING JDK
echo "Installing ${JAVA_VERSION}"
$INSTALL ${JAVA_VERSION}
echo "[ OK ] ${JAVA_VERSION} installed"

waitForKeyPress

# INSTALLING MAVEN
echo "Checking if maven is already installed..."
if find /usr/local/src/apache-maven/bin/mvn ; then
   echo "maven is already installed"
else
   echo "Installing maven ${MAVEN_VERSION}"
   wget "http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR}"
   tar -xvf ${MAVEN_TAR}
   rm ${MAVEN_TAR}
   mv "apache-maven-${MAVEN_VERSION}" "/usr/local/src/apache-maven"

   # Writing init script for maven
   MAVEN_SH=/etc/profile.d/maven.sh
   echo "# apache maven environment variables" > ${MAVEN_SH}
   echo "# MAVEN_HOME for maven 1  - M2_HOME for maven 2" >> ${MAVEN_SH}
   echo "export M2_HOME=/usr/local/src/apache-maven" >> ${MAVEN_SH}
   echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> ${MAVEN_SH}
   chmod +x ${MAVEN_SH}

   echo "[ OK ] ${MAVEN_VERSION} installed. Remember to source ${MAVEN_SH}"
fi

waitForKeyPress

# INSTALLING Xvfb
echo "Installing Xvfb " ${XVFB_VERSION}
$INSTALL xorg-x11-server-Xvfb-${XVFB_VERSION}
echo "[ OK ] Xvfb ${XVFB_VERSION} installed"

waitForKeyPress

# INSTALLING SELENIUM SERVER
echo "Checking if Selenium Server is already installed..."
if find /opt/selenium-server-standalone.jar ; then
   echo "Selenium is already downloaded"
else
   echo "Downloading Selenium..."
   wget http://selenium-release.storage.googleapis.com/${SELENIUM_MAJOR_MINOR}/${SELENIUM_JAR}
   sudo mv ${SELENIUM_JAR} /opt/selenium-server-standalone.jar
   echo "[ OK ] Selenium Server installed"
fi

waitForKeyPress

# INSTALLING GECKODRIVER
echo "Checking if Geckodriver is already installed..."
if find /usr/local/bin/geckodriver ; then
   echo "Geckodriver is already installed"
else
   echo "Downloading GeckoDriver..."
   wget http://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/${GECKODRIVER_TAR}
   echo "Decompressing Geckodriver"
   tar -xvf ${GECKODRIVER_TAR}
   echo "Deleting compressed Geckodriver"
   rm -f ${GECKODRIVER_TAR}
   echo "Moving Geckodriver to /usr/local/bin/geckodriver"
   sudo mv geckodriver /usr/local/bin/geckodriver
   echo "[ OK ] Geckodriver installed"
fi   

waitForKeyPress

# INSTALLING FIREFOX

echo "Checking if Firefox is already installed"
if find /usr/local/bin/firefox ; then
   echo "Firefox is already downloaded"
else
   echo "Downloading firefox ${FIREFOX_VERSION}"
   wget http://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/es-ES/${FIREFOX_TAR}
   echo "Decompressing firefox"
   tar -xvf ${FIREFOX_TAR}
   echo "Deleting compressed firefox"
   rm -f ${FIREFOX_TAR}*
   echo "Moving firefox to /usr/local/firefox"
   rm -rf /usr/local/firefox
   mv firefox /usr/local/firefox
   echo "Creating symbolic link to execute firefox: /url/local/bin/firefox"
   ln -s /usr/local/firefox/firefox /usr/local/bin/firefox
fi

waitForKeyPress
