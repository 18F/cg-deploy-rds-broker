#!/bin/sh

set -e

export GOPATH=$PWD/gopath
export PATH=$PATH:$GOPATH/bin

cd gopath/src/github.com/alphagov/paas-rds-broker

go test -v $(go list ./... | grep -v /vendor/ | grep -v /ci/)
