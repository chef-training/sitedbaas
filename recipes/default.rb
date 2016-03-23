#
# Cookbook Name:: sitedbaas
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# She's just a small town girl, living in a lonely world!

include_recipe 'httpdbaas::install_apache'

template '/etc/apache2/apache2.conf' do
  source 'sitedbaas.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[apache2]'
end

tarball = "#{Chef::Config[:file_cache_path]}/webfiles.tar.gz"

remote_file tarball do
  owner 'root'
  group 'root'
  mode '0644'
  source 'https://s3.amazonaws.com/binamov-delivery/webfiles.tar.gz'
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'www-data'
  group 'www-data'
end

execute 'extract web files' do
  command "tar -xvf #{tarball} -C /var/www/html/"
  not_if do
    ::File.exist?('/var/www/favicon.ico')
  end
end

service 'apache2' do
  supports :reload => :true
  action [:enable, :start]
end
