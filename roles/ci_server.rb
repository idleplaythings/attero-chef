name "ci_server"
description "Continuous Integration Server"

all_env = [
  "recipe[git]",
  "recipe[nginx]",
  "recipe[sbt::http]",
  "recipe[jenkins]",
  "recipe[jenkins-setup]"
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
      :plugins => [
        "git",
        "git-client",
        "sbt",
        "greenballs",
        "build-pipeline-plugin",
        "parameterized-trigger",
        "depgraph-view"
      ]
    }
  },
  :sbt => {
    :base_url => "http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/",
    :base_dir => "/opt/sbt",
    :version => "0.12.1",
    :checksum => "ad65a2bf1f8753c902b774d0fae2e2d884f7285b97a37e331dac5f621d7830ea"
  }
)

override_attributes()