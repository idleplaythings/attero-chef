name "game_server"
description "Game server role"
all_env = [
  "recipe[users::deploy]",
  "role[db_master]",
  "recipe[java]",
  "recipe[attero]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

override_attributes(
  :java => {
    :jdk_version => "6",
    :install_flavor => "oracle",
    :oracle => {
      :accept_oracle_download_terms => true
    }
  }
)