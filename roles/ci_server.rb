name "ci_server"
description "Continuous Integration Server"

all_env = [
  "recipe[git]",
  "recipe[nginx]",
  "recipe[jenkins]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

default_attributes(
    :jenkins => {
        :server => {
            :plugins => [ "git", "git-client", "sbt" ]
        }
    }
)