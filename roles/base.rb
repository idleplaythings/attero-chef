name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[users::sysadmins]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[git]",
  "recipe[vim]"
)
override_attributes(
  :authorization => {
    :sudo => {
      :users => ["ubuntu", "vagrant"],
      :passwordless => true
    }
  }
)