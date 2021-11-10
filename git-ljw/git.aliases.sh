#!/bin/bash

alias 2='git checkout - && echo && git log | head -n1'
alias ccc='git add .; git commit -m "CODE CLEANUP."; git push'
alias cm='gaa;gcmsg "$(prepend_commit_message)Commit manually.";gp;'
alias c='cm'
alias d='git add . && git diff --staged | tig'
alias fix="gaa;gcmsg 'FIX.';gp;"
alias gbb='git branch -vv | cat'
alias gcam='git commit -v -a --no-edit --amend'
alias gcob="git checkout -b"
alias gpo='git push origin '
alias groh='git reset --hard HEAD@{u}'
alias jj="gaa;gcmsg 'DEBUG.';gp;"
alias t="tig"
alias ts='tig show HEAD'
alias tt='tig --all'
