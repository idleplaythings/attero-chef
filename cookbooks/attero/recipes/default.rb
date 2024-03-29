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

# Deployment scripts
%w{deploy_release.sh restart_attero.sh}.each do |script|
    cookbook_file "#{base_dir}/bin/#{script}" do
        source script
        mode 0554
        owner "#{owner}"
        group "#{group}"
    end
end

# Upstart configuration
template "/etc/init/attero.conf" do
  source "upstart_service.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
    # :config_var => node[:configs][:config_var]
  )
end

deploy = Chef::EncryptedDataBagItem.load("secrets", "deploy")

# s3cmd configuration file
template "#{base_dir}/conf/s3.conf" do
  mode 0400
  owner "#{owner}"
  group "#{owner}"
  source "s3cfg.erb"
  variables(
    :access_key => deploy["aws"]["access_key"],
    :secret_key => deploy["aws"]["secret_key"]
  )
end

# Allow user to sudo restart script
sudo "attero" do
    user owner
    nopasswd true
    commands ['/opt/attero/bin/restart_attero.sh']
end

# Create attero database and db user
postgresql_connection_info = {
    :host => "localhost",
    :port => node['postgresql']['config']['port'],
    :username => 'postgres',
    :password => node['postgresql']['password']['postgres']
}

postgresql_database 'playuser' do
  connection postgresql_connection_info
  action :create
end

postgresql_database_user 'playuser' do
  connection postgresql_connection_info
  password 'playuser'
  action :create
end
