#!/bin/sh

#set -x

# This script relies on yq
if ! which -s yq
then
    echo "yq not found"
    exit 1
fi

if [ -z "$1" -o ! -f "$1" ]
then
    echo "policy file required as first arg"
    exit 1
fi

OUTPUT=$(mktemp)
trap "/bin/rm -f $OUTPUT" 0 1 2 3

POLICY_FILE="$1"
POLICY_DIR=$(dirname "$POLICY_FILE")
POLICY_CODE="$POLICY_DIR/policy.rego"

if [ ! -f "$POLICY_CODE" ]
then
    echo "policy code not found"
    echo "$POLICY_CODE"
    exit 1
fi

# Combine YAML and REGO
CODE=$(cat "$POLICY_CODE") \
    yq e '.spec.code = strenv(CODE)' "$POLICY_FILE" > $OUTPUT

kubectl -n policy-system apply -f $OUTPUT
