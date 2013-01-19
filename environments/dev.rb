name "dev"
description "The development environment"

default_attributes(
  "mysql" => {
    "bind_address" => "127.0.0.1"
  }
)
