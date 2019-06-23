#!/bin/bash

echo "Generating terraform plan file..."

terraform plan -out my.plan \
	  && terraform show -json ./my.plan > ./my.plan.json \
    && python -m json.tool ./my.plan.json > ./my.pretty.plan.json
