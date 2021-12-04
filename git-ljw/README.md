# Custom omz git plugins

**entry: git-ljw.plugin.zsh**

### how to enable this plugin?

```zsh
vim $HOME/.zshrc
# ...

plugins=(
  git
  gitfast
  zsh_reload
  zsh-autosuggestions
  git-auto-fetch
  demo    # hey there
  git-ljw # and there
)

source $HOME/.zshrc
```

+ TODO 整理出插件需要的环境变量, 统一管理, 降低重用的成本
