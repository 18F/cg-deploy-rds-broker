#!/bin/bash

set -e
set -u

cat << EOF > credentials.yml
username: "${AUTH_USERNAME}"
password: "${AUTH_PASSWORD}"
rds_config:
  region: "${AWS_REGION}"
  broker_name: "${BROKER_NAME}"
  aws_partition: "${AWS_PARTITION}"
  master_password_seed: "${MASTER_PASSWORD_SEED}"
  db_prefix: "${DB_PREFIX}"
meta:
  db_subnet_group: "${DB_SUBNET_GROUP}"
  mysql_db_security_groups: ["${MYSQL_DB_SECURITY_GROUP}"]
  postgres_db_security_groups: ["${POSTGRES_DB_SECURITY_GROUP}"]
EOF

cp -r broker-src/. broker-src-built

spruce merge --prune meta \
  broker-config/config-template.json \
  credentials.yml > \
  broker-src-built/config.yml

spruce json broker-src-built/config.yml > broker-src-built/config.json
