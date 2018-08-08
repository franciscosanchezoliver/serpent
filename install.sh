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

# INSTALLING JDK
echo "Checking if jdk is already installed..."
if yum list installed java-1.8.0* >/dev/null 2>&1; then
   echo "jdk is already installed"
else
   echo "jdk is not installed yet"
   echo "Installing " ${JAVA_VERSION}
   $INSTALL ${JAVA_VERSION}
   echo "[ OK ] ${JAVA_VERSION} installed"
fi

# INSTALLING MAVEN
echo "Checking if maven is already installed..."
if find /usr/local/src/apache-maven/bin/mvn ; then
   echo "maven is already installed"
else
   echo "Installing maven " ${MAVEN_VERSION}
   wget "http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR}"
   tar -xvf ${MAVEN_TAR}
   rm ${MAVEN_TAR}
   mv "apache-maven-${MAVEN_VERSION}" "/usr/local/src/apache-maven"

   # Writing init script for maven
   MAVEN_SH=/etc/profile.d/maven.sh
   echo "# apache maven environment variables" > ${MAVEN_SH}
   echo "# maven_home for maven 1  - m2_home for maven 2" >> ${MAVEN_SH}
   echo "export m2_home=/usr/local/src/apache-maven" >> ${MAVEN_SH}
   echo "export path=\${m2_home}/bin:\${path}" >> ${MAVEN_SH}
   chmod +x ${MAVEN_SH}

   echo "[ OK ] ${MAVEN_VERSION} installed. Remember to source ${MAVEN_SH}"
fi

# INSTALING Xvfb
echo "Checking if X Virtual Framebuffer (Xvfb) is installed..."
if yum list installed xorg-* >/dev/null 2>&1; then
   echo "Xvfb is already installed"
else
   echo "Installing Xvfb " ${XVFB_VERSION}
   $INSTALL xorg-x11-server-Xvfb-${XVFB_VERSION}
   echo "[ OK ] Xvfb ${XVFB_VERSION} installed"
fi

read -p "Press enter to continue"

# INSTALING SELENIUM SERVER
echo "Checkin if Selenium Server is already installed..."
if find /opt/selenium-server-standalone.jar ; then
   echo "Selenium is already downloaded"
else
   echo "Downloading Selenium..."
   wget http://selenium-release.storage.googleapis.com/${SELENIUM_MAJOR_MINOR}/${SELENIUM_JAR}
   sudo mv ${SELENIUM_JAR} /opt/selenium-server-standalone.jar
   echo "[ OK ] Selenium Server installed"
fi

read -p "Press enter to continue"

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
read -p "Press enter to continue"

# INSTALLING FIREFOX

echo "Checking if Firefox is already installed"
if find /usr/local/bin/firefox ; then
   echo "Firefox is already downloaded"
else
   echo "Downloading firefox " ${FIREFOX_VERSION}
   wget http://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/es-ES/${FIREFOX_TAR}
   echo "Decompressing firefox"
   tar -xvf ${FIREFOX_TAR}
   echo "Deleting compressed firefox"
   rm -f ${FIREFOX_TAR}
   echo "Moving firefox to /usr/local/firefox"
   rm -rf /usr/local/firefox
   mv firefox /usr/local/firefox
   echo "Creating symbolic link to execute firefox: /url/local/bin/firefox"
   ln -s /usr/local/firefox/firefox /usr/local/bin/firefox
fi

echo "[ OK ] Instalation completed"
