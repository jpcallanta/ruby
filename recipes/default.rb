#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, GOTPWND
#
# All rights reserved - Do Not Redistribute
#

ruby_install 'ruby_installer' do
  action :install
  version node['ruby']['version']
  source_url node['ruby']['source_url']
  build_dir node['ruby']['build_dir']
  install_prefix node['ruby']['install_prefix']
end
