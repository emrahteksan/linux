#!/bin/bash
name="visual_studio_code.deb"
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O "$name"
sudo apt install ./$name -y
rm -rf $name