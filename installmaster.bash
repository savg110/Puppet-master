#!/bin/bash
echo "***************************"
echo " "
echo "Hello $USER"
echo " "
echo "***************************"

echo "--- Setting Finnish keyboard layout ---"
setxkbmap fi

echo "--- Setting Finnish timezone ---"
sudo timedatectl set-timezone Europe/Helsinki

echo "--- Checking and getting updates ---"
sudo apt-get update

echo "--- Installing Git, Tree, Puppet and Puppetmaster ---"
sudo apt-get install -y git tree puppet puppetmaster

echo "--- Creation of "git" directory in users "home" directory ---"
cd /home/$(whoami)/
mkdir git

echo "--- Getting Puppetmaster settings from Github ---"
cd git
git clone https://github.com/siavonen/Puppet-master.git

echo "--- Replacing Puppet configurations in "/etc/puppet" directory with the ones gotten from Github ---"
sudo cp -TRv ./Puppet-master/puppet/ /etc/puppet

