#!/bin/bash

function prepend_commit_message {
  if [ -z "$branches_to_skip" ]; then
    branches_to_skip=(
      master
      incidents
      main
      ljw
      cv_zh
      cv_en
      sh_master
      s2_master
      s3_master
      s4_master
      s5_master
      develop
      test
      week
    )
  fi

  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local branch_excluded=$(printf "%s\n" "${branches_to_skip[@]}" | grep -c "^$current_branch$")

  if [[ $branch_excluded -eq 0 ]]; then
    prepended_info=$(
      git rev-parse --abbrev-ref HEAD |
      tr -d '_'                       |
      sed 's/\(....\)/&-/g'           |
      tr "[:lower:]" "[:upper:]"      |
      sed 's/-[A-Z]*$//'
    )

    echo "$prepended_info "
  fi
}
