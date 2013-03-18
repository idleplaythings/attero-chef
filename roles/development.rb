name "development"
description "Development Server"

all_env = [
  "recipe[git]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

default_attributes(
  :postgresql => {
    :pg_hba => [
      {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
      {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'ident'},
      {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
      {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'},
      # todo read network address from the node.. or something
      {:type => 'host', :db => 'all', :user => 'all', :addr => '192.168.123.0/24', :method => 'md5'},
    ],
    :config => {
      :listen_addresses => '192.168.123.123'
    }
  },
  :scala => {
    :base_url => "http://www.scala-lang.org/downloads/distrib/files",
    :base_dir => "/opt/scala",
    :version => "2.10.0",
    :checksum => "97b0ba48a0165a1451b80b1a5d7a906d8fb5429fbefe996feaa72cc1438f6095"
  },
  :play => {
    :base_url => "http://downloads.typesafe.com/play",
    :base_dir => "/opt/play",
    :version => "2.1.0",
    :checksum => "62a963389c8e75bad83eeb07c3699ccca8de4f40e416974cf56f1d0d45e83bce"
  },
  :authorization => {
    :sudo => {
      :groups => ["devops"],
        :passwordless => true
      }
  }
)

override_attributes()
