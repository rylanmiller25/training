#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: hello_cli.sh <name>"
else
  echo "Hello, $1!"
fi
