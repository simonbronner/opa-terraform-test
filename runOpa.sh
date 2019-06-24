#!/bin/bash

echo "Loading plan up in opa repl..."
docker run -it -w /app \
	     -v $(pwd):/app openpolicyagent/opa "$@"
