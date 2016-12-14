#!/bin/bash
# downloads, extracts, and installs Maven

export JAVA_HOME=dirname $(dirname $(dirname $(readlink -f $(which java) )))
export PATH=~/.local/bin/:$PATH

mkdir tmp/
cd tmp/ || exit
wget http://apache.mirror.anlx.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

tar xzvf apache-maven-3.3.9-bin.tar.gz
mkdir ~/.local/
mv apache-maven-3.3.9/* ~/.local/

