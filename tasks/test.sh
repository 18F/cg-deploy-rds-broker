#!/bin/sh

set -e

export GOPATH=$PWD/gopath:$PWD/gopath/src/github.com/alphagov/paas-rds-broker/Godeps/_workspace
export PATH=$PATH:$GOPATH/bin

cd gopath/src/github.com/alphagov/paas-rds-broker

go test -v $(go list ./... | grep -v /ci/)
