#!/bin/bash

echo "Generating terraform plan file..."

terraform plan -out ./opa/plan/my.plan \
    && terraform show -json ./opa/plan/my.plan > ./opa/plan/my.plan.json \
    && python -m json.tool ./opa/plan/my.plan.json > ./opa/plan/plan.json \
    && rm ./opa/plan/my.plan*
