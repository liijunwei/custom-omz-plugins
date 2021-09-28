#!/bin/bash

function echo_info() {
  echo "HEAD     -> $(git rev-parse HEAD)"
  echo "HEAD@{u} -> $(git rev-parse HEAD@{u})"
}

# git diff master origin/master
function gdo() {
  echo_info
  git diff HEAD@{u} HEAD
}

function tdo() {
  echo_info
  tig HEAD@{u} HEAD
}
