#!/bin/sh

PROJECT_ROOT="$(pwd)/$(dirname $0)"

cp ${PROJECT_ROOT}/hooks/* .git/hooks
