#!/usr/bin/env bash
sudo apt-get install -y curl
sudo \curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
source /usr/local/rvm/scripts/rvm
source /etc/profile.d/rvm.sh
sudo gem install chef --no-ri --no-rdoc