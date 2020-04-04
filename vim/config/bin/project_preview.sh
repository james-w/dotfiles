#!/bin/bash

if [ -z "$1" ]; then
  echo "usage: $0 DIR"
  exit 1
fi

DIR=$1

DIR="${DIR/#\~\//$HOME/}"
if [ ! -r "$DIR" ]; then
  echo "Dir not found ${DIR}"
  exit 1
fi

FILE=""

for F in "README.markdown" "README.md" "Readme.md" "README.rst" "README" "Readme"
do
    if [ -r "${DIR}/${F}" ]; then
        FILE="${DIR}/${F}"
        break
    fi
done

if [ -n "$FILE" ]; then
    head -n 100 "$FILE"
else
    if [ -x "$(command -v tree)" ]; then
        "$(command -v tree)" -C "$DIR"
    else
        /bin/ls -C --color=always "$DIR"
    fi
fi
