name "game_server"
description "Game server role"
all_env = [
  "role[base]",
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  #"dev" => all_env + ["recipe[php:module_xdebug]"],
  "dev" => all_env
)