#!/bin/bash

set -e
set -u

export GOPATH=$PWD/gopath
export PATH=$PATH:$GOPATH/bin

cd gopath/src/github.com/alphagov/paas-rds-broker/ci/acceptance

go get github.com/onsi/ginkgo/ginkgo
go get github.com/onsi/gomega

go get github.com/Masterminds/glide
glide install

curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
export PATH=$PATH:$(pwd)

cat << EOF > ./config.json
{
  "api": "${CF_API_URL}",
  "admin_user": "${CF_USERNAME}",
  "admin_password": "${CF_PASSWORD}",
  "existing_user": "${EXISTING_USER}-${RANDOM}",
  "existing_user_password": "${EXISTING_USER_PASSWORD}",
  "apps_domain": "${APP_DOMAIN}",
  "use_existing_user": true
}
EOF

export CONFIG="./config.json"

ginkgo -v -r
