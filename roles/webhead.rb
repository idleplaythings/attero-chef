name "webhead"
description "webhead server"

default_run_list = [
    "recipe[hostname]",
    "recipe[nginx]",
    "recipe[php]",
    "recipe[php-fpm]"
]

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(default_run_list)
# Environment specific run lists
env_run_lists(
    "_default" => default_run_list,
    "dev" => default_run_list,
    "prod" => default_run_list
)
# Attributes applied if the node doesn't have it set already.
default_attributes(
  :php => {
    :directives => {
        "date.timezone" => "Europe/London",
        "short_open_tag" => "0"
    }
  }
)
# Attributes applied no matter what the node has set already.
override_attributes()
