#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function upd () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m "$BASH_SOURCE"/..)"
  cd "$SELFPATH" || return $?

  local TRUNK_URL='https://github.com/reactjs/redux/trunk/'
  local FILES=(
    LICENSE.md
    docs/
    logo/
    )
  local ITEM=

  echo -n 'rm old stuff: '
  for ITEM in "${FILES[@]}"; do
    [ -e "$ITEM" ] || continue
    echo -n "$ITEM… "
    rm --preserve-root --one-file-system --recursive -- "$ITEM" || return $?
  done
  echo 'done.'

  for ITEM in "${FILES[@]}"; do
    svn export --depth infinity "$TRUNK_URL$ITEM" || return $?
  done

  sed -re 's~^(\s*"version":\s*"\S+\.)[0-9]+~\1'"$(
    date +%y%m%d%H%M)~" -i -- package.json

  return 0
}










[ "$1" == --lib ] && return 0; upd "$@"; exit $?
