MASTER_OR_MAIN_BRANCHE=(
  main
  master
)

function update-all-codebases() {
  local current_dir=$(pwd)

  for project in $(ls); do
    cd $project
    echo "Update for project $project"
    echo "========================================="
    local current_branch=$(git rev-parse --abbrev-ref HEAD)

    git fetch

    for branch in ${MASTER_OR_MAIN_BRANCHE[@]}; do
      git checkout $branch
      git add .
      git reset --hard HEAD@{u}
    done

    git checkout $current_branch

    cd ..
  done

  cd $current_dir
}
