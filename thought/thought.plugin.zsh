#!/bin/bash

function thought() {
  local msg="$*"
  [[ -z "$msg" ]] && msg="Simple, Elegant, Flexible, Nothing..."

  local content="$(date "+%Y-%m-%d %H:%M:%S") $msg"
  local thoughts_filepath="$HOME/OuterGitRepo/blog-gallary/source/thoughts/index.md"

  echo $content
  # macos use gsed, not builtin sed
  gsed -i "6i - ${content}" $thoughts_filepath
  gsed -i "6G" $thoughts_filepath

  cd $HOME/OuterGitRepo/blog-gallary

  git add . &&
  git commit -m "Commit manually." &&
  git push &&

  hexo clean  &&
  hexo deploy &&
  ssh webuser@xiaoli "cd /srv/www/blog-gallary && git pull"

  cd -
}
