name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[users::devops]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[vim]",
  "recipe[utilities::acl]"
)
override_attributes(
  :authorization => {
    :sudo => {
      :users => ["ubuntu", "vagrant"],
        :passwordless => true
      }
  }
)