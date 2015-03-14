#
# Cookbook Name:: base_setup
# Recipe:: vhosts
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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
  
end