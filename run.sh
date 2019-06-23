#!/bin/bash

docker run --rm -it \
       --name terraform \
       -e GOOGLE_CLOUD_KEYFILE_JSON=./deploy_account.json \
       -v $(pwd):/app \
       -w /app \
       hashicorp/terraform:full "$@"
