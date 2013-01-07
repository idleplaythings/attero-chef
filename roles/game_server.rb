name "game_server"
description "Game server role"
all_env = [
  "role[base]",
  "recipe[java]",
  "recipe[scala::http]",
  "recipe[play::http]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  #"dev" => all_env + ["recipe[php:module_xdebug]"],
  "dev" => all_env
)

override_attributes(
  :java => {
    :jdk_version => "6"
  },
  :scala => {
    :download_base_url => "http://www.scala-lang.org/downloads/distrib/files",
    :base_dir => "/opt/scala",
    :version => "2.10.0",
    :checksum => "a57bc12100671253d1ebc4a993e4da1896ff39022ce70c6699986d10644ac9a1"
  },
  :play => {
    :download_base_url => "http://download.playframework.org/releases",
    :base_dir => "/opt/play",
    :version => "2.1-RC1",
    :checksum => "62a963389c8e75bad83eeb07c3699ccca8de4f40e416974cf56f1d0d45e83bce"
  }
)