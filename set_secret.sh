#!/bin/bash

./generator

kubectl create secret generic "$SECRET_NAME" \
  --from-file="$XPUB_KEY_NAME"=./xpub_key.txt \
  --from-file="$XPRV_KEY_NAME"=./xprv_key.txt
