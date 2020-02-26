#!/bin/bash

MODULES="modules/axelor-open-suite/axelor-base"

run_axelor () {
  # Get the latest module updates
  git submodule update

  # Connect to dev database in cluster
  sed -i -E 's#^(db.default.url[[:blank:]]*=[[:blank:]]*).*#\1jdbc:postgresql://172.30.35.20:5432/axelor#' src/main/resources/application.properties

  ./gradlew test build
  ./gradlew run
}

if [ "$(ls -A $MODULES)" ]; then
  echo "Updating submodules and running Axelor..."
  run_axelor
else
  echo "First run, need to init submodule..."

  # Make sure git submodules are using https, not ssh
  sed -e 's|git@github.com:|https://github.com/|' -i .gitmodules
  git submodule sync
  git submodule init

  run_axelor
fi

