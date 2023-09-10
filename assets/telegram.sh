#!/bin/bash
name="telegram.tar.xz"
wget "https://telegram.org/dl/desktop/linux" -O "$name"
tar -xvf $name
mv Telegram /opt/
rm -rf $name
