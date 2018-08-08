#!/bin/bash
clear

echo "Instalando Chrome con selenium en centos"

#VERSION DEL DRIVER DE CHROME
CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
echo "La version de Chrome driver es: " $CHROME_DRIVER_VERSION

#VERSION DE SELENIUM
SELENIUM_STANDALONE_VERSION=3.8.1
echo "Version de selenium:" $SELENIUM_STANDALONE_VERSION

#SUBDIRECTORIO DE SELENIUM
SELENIUM_SUBDIR=$(echo "$SELENIUM_STANDALONE_VERSION" | cut -d"." -f-2)
echo "Subdirectorio de selenium:" $SELENIUM_SUBDIR


read -p "Pulsa enter para continuar"

#ELIMINAR DESCARGAS Y BINARIOS EXISTENTES PARA PODER EMPEZAR DESDE 0
echo "Eliminando descargas y binarios existentes para empezar de 0"
echo "Eliminando google-chrome-stable"
sudo yum remove google-chrome-stable
echo "Eliminando ~/selenium-server-standalone-*.jar"
rm ~/selenium-server-standalone-*.jar
echo "Eliminando chromedriver para linux"
rm ~/chromedriver_linux64.zip
echo "Eliminando la carpeta /usr/local/bin/chromedriver"
sudo rm /usr/local/bin/chromedriver
echo "Eliminando la carpeta /usr/local/bin/selenium-server-standalone.jar"
sudo rm /usr/local/bin/selenium-server-standalone.jar

read -p "Pulsa enter para continuar"

#INSTALANDO LAS DEPENDENCIAS
echo "Instalando las dependencias"
echo "Actualizando yum"
sudo yum update
echo "instalando los siguiente:"
echo "1º) openjdk-8-jre-headless" 
echo "2º) xvfb"
echo "3º) libxi6"
echo "4º) libconf-2-4"

read -p "Pulsa enter para continuar"

sudo yum install -y unzip java-1.8.0-openjdk-headless.x86_64 xorg-x11-server-Xvfb.x86_64 libxi6 libgconf-2.so.4


#INSTALANDO CHROME
echo "Instalando Chrome"

yum install -y google-chrome-stable

#INSTALANDO CHROME DRIVER
echo "Instalando chrome driver"













