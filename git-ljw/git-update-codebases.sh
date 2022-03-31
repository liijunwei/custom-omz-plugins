MASTER_OR_MAIN_BRANCHE=(
  main
  master
)

# TODO 使用多线程或多进程加速这个过程
function update-all-codebases() {
  local current_dir=$(pwd)

  for project in $(ls -d */); do
    cd $project

    local result=$(git rev-parse --is-inside-work-tree &> /dev/null; echo $?)

    if [ "$result" = "0" ]; then
      echo_red "Updating $project"
      echo "========================================="
      local current_branch=$(git rev-parse --abbrev-ref HEAD)

      git fetch

      for branch in ${MASTER_OR_MAIN_BRANCHE[@]}; do
        git checkout $branch
        git add .
        git reset --hard HEAD@{u}
      done

      git checkout $current_branch
    else
      echo_red "Not a git repository: $(pwd)"
    fi

    cd ..
  done

  cd $current_dir
}
