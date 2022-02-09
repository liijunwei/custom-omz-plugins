#!/bin/bash

function start_with() {
  local branch=$(echo $1 | tr '[:lower:]' '[:upper:]')
  local prefix=$(echo $2 | tr '[:lower:]' '[:upper:]')

  if [[ $branch = $prefix* ]]; then
    echo "FOUND"
  fi
}

function prepend_commit_message {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local flag_found=""

  for prefix in $WHITELIST_BRANCH_PREFIX; do
    local result=$(start_with "$current_branch" "$prefix")
    if [[ $result = "FOUND" ]]; then
      flag_found="$result"
      break
    fi
  done

  if [[ $flag_found = "FOUND" ]]; then
    local prepended_info=$(
      git rev-parse --abbrev-ref HEAD |
      tr -d '_'                       |
      sed 's/\(....\)/&-/g'           |
      tr "[:lower:]" "[:upper:]"      |
      sed 's/-[A-Z]*$//'
    )

    echo "$prepended_info "
  fi
}
