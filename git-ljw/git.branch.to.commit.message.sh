#!/bin/bash

function prepend_commit_message {
  if [ -z "$BRANCHES_TO_SKIP" ]; then
    BRANCHES_TO_SKIP=(
      master
      incidents
      main
      tmp
      ljw
      fixdoc
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
  local branch_excluded=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$current_branch$")

  if [[ $branch_excluded -eq 0 ]]; then
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
