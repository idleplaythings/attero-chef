name "vagrant"
description "vagrant instance role"

default_run_list = []

run_list(default_run_list)

env_run_lists(
    "_default" => default_run_list,
    "dev" => default_run_list,
    "prod" => default_run_list
)

default_attributes(
  :authorization => {
    :sudo => {
      :users => ["vagrant"],
      :passwordless => true
    }
  }
)

override_attributes()
