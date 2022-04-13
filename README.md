# Magic Therein

Suggestions are welcome.

## usage

```bash
function backup_and_setup() {
  local backup_foldername="plugins-backup@$(date "+%s")"

  cd $HOME/.oh-my-zsh/custom

  [ -d "./plugins" ] && echo "Backup in progress" && mv plugins $backup_foldername || echo "Directory not exists."
  git clone git@github.com:liijunwei/custom-omz-plugins.git plugins
  echo "New plugin setup done, go get old plugins in folder $backup_foldername"
}

```
