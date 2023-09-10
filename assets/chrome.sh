#!/bin/bash
name="google-chrome-stable_current_amd64.deb"
wget https://dl.google.com/linux/direct/$name
sudo apt install ./$name -y
rm -rf $name
