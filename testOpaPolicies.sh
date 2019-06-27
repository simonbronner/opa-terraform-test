#!/bin/bash

echo "Loading plan up in opa repl..."
docker run -it -w /app \
	     -v $(pwd)/opa:/app openpolicyagent/opa run \
       -w -l debug \
       /app
