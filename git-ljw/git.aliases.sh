#!/bin/bash

alias 2='git checkout - && echo && git log | head -n1'
alias cm='gaa;gcmsg "$(prepend_commit_message)Commit manually.";'
alias c='cm'
alias d='git add . && git diff --staged | tig'
alias fix="gaa;gcmsg 'FIX.';gp;"
alias gbb='git branch -avv | fzf'
alias gcam='git commit -v -a --no-edit --amend --allow-empty'
alias gcob="git checkout -b"
alias gpo='git push origin '
alias groh='git add . && git reset --hard HEAD@{u}'
alias jj="gaa;gcmsg 'Debugging.';gp;"
alias t="tig"
alias tt='tig --all'
