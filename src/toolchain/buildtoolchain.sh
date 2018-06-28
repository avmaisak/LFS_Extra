#!/bin/sh
#tools location
set -e

SRC_LOCATION=/opt/src
TOOLS_LOCATION=/opt/tools

#start
clear

#create directories
rm -rvf $TOOLS_LOCATION
rm -rvf $SRC_LOCATION
mkdir -pv $TOOLS_LOCATION
mkdir -pv $SRC_LOCATION

#create user
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs
chown -v lfs $TOOLS_LOCATION
chown -v lfs $LFS/sources

ln -sv $TOOLS_LOCATION /

su - lfs

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile
