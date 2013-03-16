bundle exec knife ec2 server create \
    --ssh-key hosts \
    --identity-file ~/.ssh/idleplaythings-provisioning.pem \
    --ssh-user ubuntu \
    --distro "ubuntu12.04-gems" \
    --environment prod \
    --image "ami-e1e8d395" \
    --flavor "m1.small" \
    --run-list "role[base],role[ci_server]" \
    --node-name "ops.idleplaythings.com" \
    --availability-zone "eu-west-1a" \
    --region "eu-west-1" \
    --groups "default,ci-server"

bundle exec knife ec2 server create \
    --ssh-key hosts \
    --identity-file ~/.ssh/idleplaythings-provisioning.pem \
    --ssh-user ubuntu \
    --distro "ubuntu12.04-gems" \
    --environment prod \
    --image "ami-e1e8d395" \
    --flavor "t1.micro" \
    --run-list "role[base]" \
    --node-name "demo.hulldowngame.com" \
    --availability-zone "eu-west-1a" \
    --region "eu-west-1" \
    --groups "default,hulldown-app,hulldown-app-db"