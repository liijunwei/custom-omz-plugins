# inspired by gitlab source@scripts/lint-conflicts.sh

function git-check-confliecs(){
  output=$(git grep -En '^<<<<<<< ')
  echo ${output:-"No Confliecs Found"}
}
