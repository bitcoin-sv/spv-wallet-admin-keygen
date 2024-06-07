#!/bin/bash

function print_help() {
    echo "Usage: ./keygen.sh [-p | --print] [-k | --k8s] [SECRET_NAME] [XPUB_KEY_NAME] [XPRV_KEY_NAME]"
    echo "  -p | --print  Print the xpub and xprv keys"
    echo "  --no-k8s  Do not store the keys in a k8s secret"
    echo "  -s | --secret  Name of the k8s secret to store the keys in (only used with -k)"
    echo "  -pb | --pub-name  Name of the key in k8s secret to store the xpub key (only used with -k)"
    echo "  -pv | --prv-name  Name of the key in k8s secret to store the xpriv key (only used with -k)"
    echo "  -h | --help  Display this help message"
}

function set_secret_key_if_not_exists() {
  local type=$1
  local key_name=$(tr '[:lower:]' '[:upper:]' <<< $type)
  key_name="${key_name}_KEY_NAME"
  local key="${!key_name}"

  kubectl get secret "$SECRET_NAME" -o jsonpath='{.data}' | grep -q "$key"
  if [ $? -eq 1 ]; then
    value="$(base64 < "${type}_key.txt" | tr -d '\n')"
    kubectl patch secret "$SECRET_NAME" \
      --type='json' \
      -p='[{"op": "add", "path": "/data/'"$key"'", "value": "'"$value"'" }]'
  fi
}

# setup script from arguments. set variable $show if -p or --print is used, set variable $k8s if -k or --k8s is used
show=false
k8s=true
SECRET_NAME=spv-wallet-keys
XPUB_KEY_NAME=admin_xpub
XPRV_KEY_NAME=admin_xpriv

while [ "$1" != "" ]; do
  case $1 in
    -p | --print )
    show=true
    ;;
    --no-k8s )
    k8s=false
    ;;
    -s | --secret )
    SECRET_NAME=$2
    shift
    ;;
    -pb | --xpub-key )
    XPUB_KEY_NAME="$2"
    shift
    ;;
    -pv | --xprv-key )
    XPRV_KEY_NAME="$2"
    shift
    ;;
    -h | --help )
    print_help
    exit 0
    ;;
  esac
  shift
done

./generator

# print the keys if -p or --print is used
if [ "$show" = true ]; then
  echo "Public key:"
  cat xpub_key.txt
  echo ""
  echo "Private key:"
  cat xprv_key.txt
fi

# store the keys in a k8s secret if -k or --k8s is used
if [ "$k8s" = true ]; then
  #  create secret if it does not exist
  kubectl get secret "$SECRET_NAME" > /dev/null 2>&1
  if [ $? -eq 1 ]; then
    kubectl create secret generic "$SECRET_NAME" \
      --from-file="$XPUB_KEY_NAME"=./xpub_key.txt \
      --from-file="$XPRV_KEY_NAME"=./xprv_key.txt
  else
    set_secret_key_if_not_exists xpub
    set_secret_key_if_not_exists xprv
  fi
fi
