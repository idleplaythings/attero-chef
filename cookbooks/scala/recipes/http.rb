#
# Cookbook Name:: scala
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

base_dir = node['scala']['base_dir']
base_url = node['scala']['base_url']
version = node['scala']['version']

package "tar" do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/scala-#{version}.tgz" do
  source "#{base_url}/scala-#{version}.tgz"
  mode "0644"
  checksum node['scala']['checksum']
end

directory node['scala']['base_dir'] do
    owner "root"
    group "root"
    mode "0755"
    recursive true
end

bash "install scala" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -zxvf scala-#{version}.tgz
  mv scala-#{version} #{base_dir}
  EOF
  not_if do File.exist?("#{base_dir}/scala-#{version}") end
end

template "/etc/profile.d/scala.sh" do
  source "scala.sh.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :base_dir => base_dir,
    :version => version
  })
end
