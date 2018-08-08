#!/bin/bash

echo "Creating virtual screen in port 99..."
export DISPLAY=:99
Xvfb :99 -ac -screen 0 1280x1024x24 &

