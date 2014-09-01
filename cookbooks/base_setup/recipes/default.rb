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
include_recipe "mysql::server"
include_recipe "mysql::client"
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

# Installing php pear packages
# IMPORTANT: "pecl.php.net" is not available for now.
["PHP_CodeSniffer", "imagick", "xdebug"].each do |php_package|
  php_pear php_package do
    action :install
    preferred_state "stable"
  end
end

# Generate selfsigned ssl
#execute "make-ssl-cert" do
#  command "make-ssl-cert generate-default-snakeoil --force-overwrite"
#  ignore_failure true
#  action :nothing
#end

# Initialize sites data bag
sites = []
begin
  sites = data_bag("sites")
rescue
  puts "Unable to load sites data bag."
end

# Configure sites
sites.each do |name|
  site = data_bag_item("sites", name)

  # Add site to apache config
  web_app site["id"] do
    template "vhost.conf.erb"
    server_name site["host"]
    server_aliases site["aliases"]
#    server_include site["include"]
    docroot site["docroot"] ? site["docroot"] : "/srv/website/#{site["id"]}"
  end

   # Add site info in /etc/hosts
   #bash "hosts" do
   #  code "echo 127.0.0.1 #{site["host"]} >> /etc/hosts"
   #end
end