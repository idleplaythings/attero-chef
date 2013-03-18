name "attero"
description "Attero - The Game server"

all_env = [
  "recipe[users::deployment]",
  "recipe[java]",
  "recipe[attero]"
]

run_list(all_env)

env_run_lists(
  "_default" => all_env,
  "prod" => all_env,
  "dev" => all_env
)

default_attributes(
  :java => {
    :jdk_version => "6",
    :install_flavor => "oracle",
    :oracle => {
      :accept_oracle_download_terms => true
    }
  },
  :authorization => {
    :sudo => {
      :include_sudoers_d => true
    }
  }
)

override_attributes()
