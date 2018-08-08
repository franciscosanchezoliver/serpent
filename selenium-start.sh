#!/bin/bash

echo "Starting SERPENT server..."
echo "Creating virtual screen in port 99..."
export DISPLAY=:99
Xvfb :99 -ac -screen 0 1280x1024x24 &

echo "Starting selenium server..."
# java -jar /opt/selenium-server-standalone.jar -enabledPassThrough false &

echo "SERPENT started"

