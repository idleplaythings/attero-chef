#
# Cookbook Name:: scala
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

base_dir = node['play']['base_dir']
base_url = node['play']['base_url']
version = node['play']['version']

package "unzip" do
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/play-#{version}.zip" do
  source "#{base_url}/#{version}/play-#{version}.zip"
  mode "0644"
  checksum node['play']['checksum']
end

directory node['play']['base_dir'] do
    owner "root"
    group "root"
    mode "0755"
    recursive true
end

bash "install play framework" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  unzip play-#{version}.zip
  mv play-#{version} #{base_dir}
  cd #{base_dir}/play-#{version}/framework
  ./build build-repository
  EOF
  not_if do File.exist?("#{base_dir}/play-#{version}") end
end

template "/etc/profile.d/play.sh" do
  source "play.sh.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :base_dir => base_dir,
    :version => version
  })
end
