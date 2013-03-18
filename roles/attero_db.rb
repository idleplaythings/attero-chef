name "attero_db"
description "Attero Database"

all_env = [
  "recipe[postgresql::server]",
  "recipe[postgresql::pl_python]",
  "recipe[database::postgresql]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

override_attributes()
