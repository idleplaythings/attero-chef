name "base"
description "Base role applied to all nodes"

all_env = [
  "recipe[users::devops]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[vim]",
  "recipe[utilities::acl]",
  "recipe[utilities::s3cmd]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

default_attributes(
  :authorization => {
    :sudo => {
      :groups => ["devops"],
      :passwordless => true
    }
  }
)

override_attributes()
