#!/bin/sh

set -e
set -u

export GOPATH=$PWD/gopath
export PATH=$PATH:$GOPATH/bin

cd gopath/src/github.com/alphagov/paas-rds-broker/ci/acceptance

go get github.com/Masterminds/glide
glide install

cat << EOF > config.json
{
  "api": "${CF_API_URL}",
  "admin_user": "${CF_USERNAME}",
  "admin_password": "${CF_PASSWORD}"
}
EOF

export CONFIG="./config.json"

ginkgo -r
