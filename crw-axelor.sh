#!/bin/bash

run_axelor () {
  # Get the latest module updates
  git submodule update

  # Connect to dev database in cluster
  sed -i -E 's#^(db.default.url[[:blank:]]*=[[:blank:]]*).*#\1jdbc:postgresql://172.30.35.20:5432/axelor#'

  ./gradlew test build
  ./gradlew run
}

if [ "$1" == 'firstrun' ]; then
  # Make sure git submodules are using https, not ssh
  sed -e 's|git@github.com:|https://github.com/|' -i .gitmodules
  git submodule sync
  git submodule init

  run_axelor
elif [ "$1" == 'run' ]; then
  run_axelor
elif [ -z "$1" ]; then
  echo 'You must supply a command for this script to run!'
  exit 1
fi

