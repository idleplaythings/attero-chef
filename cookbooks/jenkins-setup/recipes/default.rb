#
# Cookbook Name:: jenkins-setup
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Set up known hosts for Jenkins SSH
cookbook_file "#{node[:jenkins][:server][:home]}/.ssh/known_hosts" do
  source "jenkins_known_hosts"
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
