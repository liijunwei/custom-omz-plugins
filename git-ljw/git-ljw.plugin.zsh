#!/bin/bash

# Plugin entry
_git_ljw_path=$(dirname $(realpath $BASH_SOURCE))

for f in $(ls $_git_ljw_path/*.sh); do
  source $f;
done
