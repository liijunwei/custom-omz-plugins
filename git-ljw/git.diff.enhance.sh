#!/bin/bash

# git diff master origin/master
function gdo() {
  git diff HEAD@{u} HEAD
}

function tdo() {
  tig HEAD@{u} HEAD
}
