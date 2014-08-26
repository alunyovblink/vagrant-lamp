#!/usr/bin/env bash
# Installing curl
sudo apt-get install -y curl

# Installing and setting up RVM and latest Ruby
sudo \curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3
source /usr/local/rvm/scripts/rvm
source /etc/profile.d/rvm.sh

# Installing chef
gem install chef --no-ri --no-rdoc