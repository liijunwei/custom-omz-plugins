#!/bin/bash

# Plugin entry
# _git_ljw_path=$(dirname $(realpath $BASH_SOURCE)) # on linux
_git_ljw_path="$(dirname -- $0)" # on macos

for f in $(ls $_git_ljw_path/*.sh); do
  source $f;
done
