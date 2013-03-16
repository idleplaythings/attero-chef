#
# Cookbook Name:: attero
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

base_dir    = "/opt/attero"

owner       = "deploy"
group       = "deploy"

# Base directory
directory "#{base_dir}" do
  mode 00775
  owner "#{owner}"
  group "#{group}"
  action :create
  recursive true
end

# Other directories
%w{logs releases bin conf}.each do |dir|
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

deploy = Chef::EncryptedDataBagItem.load("secrets", "deploy")

# s3cmd configuration file
template "#{base_dir}/conf/s3.conf" do
  mode 0600
  owner "#{owner}"
  group "#{owner}"
  source "s3cfg.erb"
  variables(
    :access_key => deploy["aws"]["access_key"],
    :secret_key => deploy["aws"]["secret_key"]
  )
end
