# 環境変数の設定
export LANG=ja_JP.UTF-8
export TERM=xterm-256color

# エイリアスの設定
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'

# ローカルセッティングを読み込む
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

