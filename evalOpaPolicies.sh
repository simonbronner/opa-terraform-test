#!/bin/bash

./genPlan.sh

echo "Evaluating OPA Policies in data.contino.test namespace"
docker run -it -w /app \
	     -v $(pwd)/opa:/app openpolicyagent/opa eval \
       --data /app \
       --format=values \
       data.contino.test
