#!/bin/bash
# This script is for installing OpenAI Gym without super user access
# Currently, python, git, make, and gcc need to already be installed

mkdir tmp/
cd tmp/

# checks if a commadExists (ie it is installed)
commandExists () {
    type "$1" &> /dev/null ;
}

#installs pip
if ! commandExists pip; then
	wget https://bootstrap.pypa.io/get-pip.py
	python get-pip.py --user
fi

PATH=$PATH:~/.local/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib

#installs cmake
if ! commandExists cmake; then
	git clone https://cmake.org/cmake.git 
	cd cmake
	./configure --prefix=~/.local/
	make
	make install
	cd ../
else
	#checks if cmake's shared library is the correct version
	#if cmake is compiled on a newer computer, it might not run on an older computer
	regex="(GLIBC_)(\d\.\d*)"
	regex1="(\d\.\d*)"
	LIBC_VER_NEEDED=ldd ~/.local/bin/cmake |& grep -Po regex | grep -Pom 1 regex1
	LIBC_CURRENT_VER=ldd --version | awk '/ldd/{print $NF}'

	if [ bc "$LIBC_VER_NEEDED > $LIBC_CURRENT_VER" ]; then
	  #builds and compiles latest version of libc
		git clone git://sourceware.org/git/glibc.git
		mkdir glibcbuild/
		cd glibcbuild/
		../glibc/configure --prefix=~/.local/
		make
		make install
	fi
fi

#installs openai
git clone https://github.com/openai/gym.git
cd gym
pip install -e '.[atari]' --user
cd ../
