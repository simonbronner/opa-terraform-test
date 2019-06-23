#!/bin/bash

./genPlan.sh

echo "Loading plan up in opa repl..."
docker run -it -w /app \
	     -v $(pwd):/app openpolicyagent/opa run \
       -w -l debug \
       plan:my.pretty.plan.json \
       approved_providers:approved-providers.json \
       rules.rego
