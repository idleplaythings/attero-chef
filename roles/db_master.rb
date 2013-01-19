name "db_master"
description "Master database server"

all_env = [
  "recipe[mysql::server]",
  "recipe[postgresql::server]",
  "recipe[postgresql::pl_python]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)