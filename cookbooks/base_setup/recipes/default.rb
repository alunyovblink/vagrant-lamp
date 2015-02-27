#
# Cookbook Name:: base_setup
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "build-essential"
#include_recipe "apache2"
#include_recipe "mysql::server"
#include_recipe "mysql::client"
#include_recipe "php"
#include_recipe "php::module_apc"
#include_recipe "php::module_mysql"
#include_recipe "php::module_curl"
#include_recipe "apache2::mod_php5"
#include_recipe "apache2::mod_rewrite"
#include_recipe "apache2::mod_ssl"

# Install system packages
["mc", "tmux", "make"].each do |a_package|
  package a_package
end
