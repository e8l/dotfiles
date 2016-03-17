#---------------------------------------
# zsh 設定ファイル
# 環境変数やエイリアスは.zshenvに記入
#---------------------------------------

########################################
# autoload
# zshの設定を書くのに色々便利にしてくれる
# ものを色々読み込む
########################################
zstyle :compinstall filename '/home/yuta/.zshrc'

# 色々初期設定してくれるやつ
autoload -Uz compinit
compinit

# 色関連
autoload -Uz colors
colors

# GitなどのVCSの情報をなんやかんや
autoload -Uz vcs_info

# zshなどのバージョンを簡単に調べる
autoload -Uz is-at-least

# 特定タイミングで関数などを実行させる
autoload -Uz add-zsh-hook

# コマンド履歴検索を有効にさせる
autoload history-search-end

########################################
# 補完スタイル
# zstyleによる設定を記述
########################################

# _oldlist 前回の補完結果を再利用する
# _expand グロブや変数などの展開
# _complete 普通の補完
# _match vi* -> vi | vim などの補完ができる
# _prefix カーソルの位置で補完
# _approximate ミススペルを訂正して補完
# _history コマンド履歴から補完
# _ignored 補完候補から除外したものも補完候補にする？
#zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _history

# 方向キーで補完候補を選択可能にする
zstyle ':completion:*:default' menu select=2

# 補完候補がなければより曖昧に候補を探す。
# m:{a-z}={A-Z} 小文字を大文字に変えたものでも補完する。
# r:|[._-]=* ._-の前にワイルドカードがあるものとして補完する。
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

# 補完候補に色を付ける。
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ~/f* を /home/user/foo ではなく ~/foo として展開
zstyle ':completion:*' keep-prefix

# オブジェクトファイルとか中間ファイルを補完しない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# apt-getとかdpkgコマンドをキャッシュを使って速くする
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zsh/cache

## 詳細な情報を使わない
zstyle ':completion:*' verbose no

## sudo の時にコマンドを探すパス
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# ヒストリ関係
########################################
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# 同時起動のzshの間でヒストリを共有
setopt share_history

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンドをヒストリに残さない
setopt hist_ignore_space

# 余分なスペースの含まれるコマンドはそれを削除してヒストリに保存
setopt hist_reduce_blanks

########################################
# オプション設定
########################################

# emacsバインドで操作
bindkey -e

# beep無効
setopt no_beep
setopt nolistbeep # 補完時

# 日本語ファイル名を表示
setopt print_eight_bit

# コマンド訂正を有効にする
setopt correct

#カッコの対応を自動補完
setopt auto_param_keys

# コマンドライン引数の「=」以降も補完
setopt magic_equal_subst

# ディレクトリ名だけで勝手にcdしてくれる
setopt auto_cd

# cdしたら勝手にディレクトリスタックに入れてくれる
# cd のあとにTabを押すだけで履歴表示してくれる
setopt auto_pushd

# ディレクトリスタックにすでに入っているディレクトリはスタックしない
setopt pushd_ignore_dups

# 高機能なワイルドカード展開を有効
setopt extended_glob

# プロンプト文字列で各種展開を行なう
setopt prompt_subst

# 改行コードで終らない出力もちゃんと出力する
setopt no_promptcr

# Ctrl-D でログアウトするのを抑制する。
setopt  ignore_eof

# グロブがマッチしないときエラーにしない
# http://d.hatena.ne.jp/amt/20060806/ZshNoGlob
setopt null_glob

# ドットを明示しなくてもドットファイルにマッチ
setopt globdots

########################################
# コマンド履歴探索
########################################
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

########################################
# プロンプトの表示設定
########################################
case ${UID} in
0)
    PROMPT="%n%% "
    PROMPT2="%B%_#%b "
    SPROMPT="%B%F{red}%r is correct? [n,y,a,e]:%f%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%F{green}%n%%%f "
    PROMPT2="%F{green}%_%%%f "
    SPROMPT="%F{magenta}%r is correct? [n,y,a,e]:%f "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%F{white}${HOST%%.*} ${PROMPT}"
    ;;
esac

########################################
# VCS関連の表示設定
########################################
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats ' (%F{yellow}%b|%a%f)'
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
  zstyle ':vcs_info:git:*' unstagedstr "%F{ref}-"
  zstyle ':vcs_info:git:*' formats '(%F{green}%c%u%b%f)'
  zstyle ':vcs_info:git:*' actionformats '(%F{green}%c%u%b|%a%f)'
fi
precmd () { vcs_info }
RPROMPT='[%~${vcs_info_msg_0_}]'
