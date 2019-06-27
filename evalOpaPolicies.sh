#!/bin/bash

echo "Evaluating OPA Policies in data.contino.rules namespace"
docker run -it -w /app \
	     -v $(pwd)/opa:/app openpolicyagent/opa eval \
       --data /app \
       --format=values \
       data.contino.rules
