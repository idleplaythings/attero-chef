#
# Cookbook Name:: scala
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

base_dir = node['sbt']['base_dir']
base_url = node['sbt']['base_url']
version = node['sbt']['version']

directory "#{base_dir}/#{version}" do
    owner "root"
    group "root"
    mode "0755"
    recursive true
end

remote_file "#{base_dir}/#{version}/sbt-launch.jar" do
  source "#{base_url}/#{version}/sbt-launch.jar"
  mode "0644"
  checksum node['sbt']['checksum']
end

link "#{base_dir}/current" do
  to "#{base_dir}/#{version}"
end
