#!/bin/bash

kubectl create secret generic "$SECRET_NAME_ENV" \
  --from-file="$XPUB_KEY_NAME_ENV"=./xpub_key.txt \
  --from-file="$XPRV_KEY_NAME_ENV"=./xprv_key.txt
