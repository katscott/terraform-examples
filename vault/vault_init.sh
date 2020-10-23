#!/bin/bash

export VAULT_ADDR='http://127.0.0.1:8200'

init_output=`vault operator init`
echo ${init_output}

root_key=`echo ${init_output} | grep "Initial Root Token:" | awk '$1 == "Initial Root Token:" {print $2}'`
echo ${root_key}
# key1=`cat ${init_output} | grep Unseal Key 1: | awk '$1 == "Unseal Key 1:" {print $2}'`
# key2=`cat ${init_output} | grep Unseal Key 2: | awk '$1 == "Unseal Key 2:" {print $2}'`
# key3=`cat ${init_output} | grep Unseal Key 3: | awk '$1 == "Unseal Key 3:" {print $2}'`

# vault operator unseal ${key1}
# vault operator unseal ${key2}
# vault operator unseal ${key3}

# vault login ${root_key}

# vault secrets enable -version=1 -path=secret kv

# vault kv put secret/app/password password=secret123
