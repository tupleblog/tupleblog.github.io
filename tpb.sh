#!/usr/bin/env bash

# ---------------------------
#      helper functions
# ---------------------------
## detect if it is on which system, because inplace sed on MacOS requires backup extension
isMac() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    return 0
  fi

  return 1
}

## sed inplace for cross platform
xsed() {
  # $1 : pattern
  # $2 : filename
  if isMac; then
    sed -Ei '' "$1" "$2"
  else
    sed -Ei "$1" "$2"
  fi
}

## check if imageMagick is installed
checkRequirement() {
  if ! type ruby > /dev/null; then
    echo "ruby not found, please install.. (rbenv recommended)"
    return 1
  fi
  if ! type gem > /dev/null; then
    echo "gem not found, please install.. (rbenv recommended)"
    return 1
  fi
  return 0
}

## display help
displayHelp(){
    echo "Usage: $0 [-i] [-d]"
    echo
    echo "  Options:"
    echo "    -i, --install     install dependencies with gem (gem install bundler) and bundler (bundle install)."
    echo "    -d, --debug       serve jekyll locally using bundler."
    echo

    exit 1
}

# ---------------------------
#      functions
# ---------------------------
## install dependencies
installDeps() {
  if ! type bundle > /dev/null; then
    echo -e ">> bundle not found, installing..\n"
    gem install bundler
  fi

  echo -e ">> installing bundles..\n"
  bundle install
}

## debug locally
debugLocally() {
  local config_file
  config_file="./_config.yml"

  # comment url line on start
  xsed 's/^(url:.*)/\# \1/' $config_file

  # serve jekyll locally
  JEKYLL_ENV=production bundle exec jekyll serve

  # uncomment url line on stop
  xsed 's/^#\s*(url: https\:\/\/tupleblog.*)/\1/' $config_file
}

# ---------------------------
#      main
# ---------------------------

main() {
  # check requirement first
  if ! checkRequirement; then exit 1; fi

  case $1 in
    '-i' | '--install' )
      installDeps
      exit
    ;;
    '-d' | '--debug' )
      debugLocally
      exit
    ;;
    '-t' | '--test' )
      debugLocally
    #   displayHelp
    ;;
    * )
      displayHelp
    ;;
  esac
}

main $@