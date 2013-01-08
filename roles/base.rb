name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[sudo]",
  "recipe[apt]",
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