#
# Cookbook Name:: base_setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"
include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_apc"
include_recipe "php::module_mysql"
include_recipe "php::module_curl"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"

# Install system packages
["mc", "tmux", "make"].each do |a_package|
  package a_package
end

# Installing mysql server.
mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password 'rootpass'
  action [:create, :start]
end

# Install php required
["memcached", "imagemagick", "libmagickcore-dev", "libmagickwand-dev",
  "php-apc", "php5-memcache", "php5-memcached", "php5-common",
  "php5-cli", "php5-xmlrpc", "php-soap", "php5-gd", "php5-intl",
  "php5-mysql", "libapache2-mod-php5"].each do |b_package|
  package b_package
end

execute "pear clear-cache"
execute "pear config-set auto_discover 1"

["pecl.php.net", "pear.php.net", "pear.symfony.com"].each do |channel|
    php_pear_channel channel do
      action :update
    end
end

apache_site "default" do 
  enable true
end