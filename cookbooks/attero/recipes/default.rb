#
# Cookbook Name:: attero
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

base_dir    = "/opt/supybot"

user        = "attero"
owner       = "attero"
group       = "attero"


# todo only if user doesn't exist
user "#{user}" do
  comment "attero user"
  system true
  shell "/bin/sh"
  home "/home/#{user}"
end

# Base directory
directory "#{base_dir}" do
  mode 00775
  owner "#{owner}"
  group "#{group}"
  action :create
  recursive true
end

# Other directories
%w{logs releases}.each do |dir|
   directory "#{base_dir}/#{dir}" do
      mode 00775
      owner "#{owner}"
      group "#{group}"
      action :create
      recursive true
   end
end

# Upstart configuration
template "/etc/init/attero.conf" do
  source "upstart_service.conf.erb"
  mode 0775
  owner "#{owner}"
  group "#{group}"
  variables(
    # :config_var => node[:configs][:config_var]
  )
end