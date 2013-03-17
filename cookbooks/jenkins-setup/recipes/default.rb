#
# Cookbook Name:: jenkins-setup
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Set Jenkins SSH config
cookbook_file "#{node[:jenkins][:server][:home]}/.ssh/config" do
  source "ssh_config"
  mode 0644
  owner "jenkins"
  group "jenkins"
end

# Set up Jenkins SSH keys
ci = Chef::EncryptedDataBagItem.load("secrets", "ci")

file "#{node[:jenkins][:server][:home]}/.ssh/id_rsa" do
  mode 0600
  owner "jenkins"
  group "jenkins"
  content ci["ssh"]["private_key"]
end

file "#{node[:jenkins][:server][:home]}/.ssh/id_rsa.pub" do
  mode 0644
  owner "jenkins"
  group "jenkins"
  content ci["ssh"]["public_key"]
end

# Create s3cmd configuration file
template "#{node[:jenkins][:server][:home]}/.s3cfg" do
  mode 0600
  owner "jenkins"
  group "jenkins"
  source "s3cfg.erb"
  variables(
    :access_key => ci["aws"]["access_key"],
    :secret_key => ci["aws"]["secret_key"]
  )
end