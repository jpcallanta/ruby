#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# attribute :version, :kind_of => String
# attribute :source_url, :kind_of => String
# attribute :build_dir, :kind_of => String
# attribute :install_prefix, :kind_of => String
# default['ruby']['version'] = '2.2.2'
# default['ruby']['source_url'] = 'ftp://ftp.ruby-lang.org/pub/ruby/2.2'
# default['ruby']['build_dir'] = '/tmp'
# default['ruby']['install_prefix'] = '/usr/local'

ruby_install 'ruby_installer' do
  action :install
  version node['ruby']['version']
  source_url node['ruby']['source_url']
  build_dir node['ruby']['build_dir']
  prefix node['ruby']['install_prefix']
end
