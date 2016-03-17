#---------------------------------------
# zsh �ݒ�t�@�C��
# ���ϐ���G�C���A�X��.zshenv�ɋL��
#---------------------------------------

########################################
# autoload
# zsh�̐ݒ�������̂ɐF�X�֗��ɂ��Ă����
# ���̂�F�X�ǂݍ���
########################################
zstyle :compinstall filename '/home/yuta/.zshrc'

# �F�X�����ݒ肵�Ă������
autoload -Uz compinit
compinit

# �F�֘A
autoload -Uz colors
colors

# Git�Ȃǂ�VCS�̏����Ȃ�₩���
autoload -Uz vcs_info

# zsh�Ȃǂ̃o�[�W�������ȒP�ɒ��ׂ�
autoload -Uz is-at-least

# ����^�C�~���O�Ŋ֐��Ȃǂ����s������
autoload -Uz add-zsh-hook

# �R�}���h����������L���ɂ�����
autoload history-search-end

########################################
# �⊮�X�^�C��
# zstyle�ɂ��ݒ���L�q
########################################

# _oldlist �O��̕⊮���ʂ��ė��p����
# _expand �O���u��ϐ��Ȃǂ̓W�J
# _complete ���ʂ̕⊮
# _match vi* -> vi | vim �Ȃǂ̕⊮���ł���
# _prefix �J�[�\���̈ʒu�ŕ⊮
# _approximate �~�X�X�y����������ĕ⊮
# _history �R�}���h��������⊮
# _ignored �⊮��₩�珜�O�������̂��⊮���ɂ���H
#zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _history

# �����L�[�ŕ⊮����I���\�ɂ���
zstyle ':completion:*:default' menu select=2

# �⊮��₪�Ȃ���΂��B���Ɍ���T���B
# m:{a-z}={A-Z} ��������啶���ɕς������̂ł��⊮����B
# r:|[._-]=* ._-�̑O�Ƀ��C���h�J�[�h��������̂Ƃ��ĕ⊮����B
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# �⊮���@���ɃO���[�v������B
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

# �⊮���ɐF��t����B
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ~/f* �� /home/user/foo �ł͂Ȃ� ~/foo �Ƃ��ēW�J
zstyle ':completion:*' keep-prefix

# �I�u�W�F�N�g�t�@�C���Ƃ����ԃt�@�C����⊮���Ȃ�
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# �ϐ��̓Y����⊮����
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# apt-get�Ƃ�dpkg�R�}���h���L���b�V�����g���đ�������
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zsh/cache

## �ڍׂȏ����g��Ȃ�
zstyle ':completion:*' verbose no

## sudo �̎��ɃR�}���h��T���p�X
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ../ �̌�͍�����f�B���N�g����⊮���Ȃ�
zstyle ':completion:*' ignore-parents parent pwd ..

# ps �R�}���h�̃v���Z�X���⊮
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# �q�X�g���֌W
########################################
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# �����N����zsh�̊ԂŃq�X�g�������L
setopt share_history

# ������ zsh �𓯎��Ɏg�����Ȃ� history �t�@�C���ɏ㏑�������ǉ�
setopt append_history

# �����R�}���h���q�X�g���Ɏc���Ȃ�
setopt hist_ignore_all_dups

# �X�y�[�X����n�܂�R�}���h���q�X�g���Ɏc���Ȃ�
setopt hist_ignore_space

# �]���ȃX�y�[�X�̊܂܂��R�}���h�͂�����폜���ăq�X�g���ɕۑ�
setopt hist_reduce_blanks

########################################
# �I�v�V�����ݒ�
########################################

# emacs�o�C���h�ő���
bindkey -e

# beep����
setopt no_beep
setopt nolistbeep # �⊮��

# ���{��t�@�C������\��
setopt print_eight_bit

# �R�}���h������L���ɂ���
setopt correct

#�J�b�R�̑Ή��������⊮
setopt auto_param_keys

# �R�}���h���C�������́u=�v�ȍ~���⊮
setopt magic_equal_subst

# �f�B���N�g���������ŏ����cd���Ă����
setopt auto_cd

# cd�����珟��Ƀf�B���N�g���X�^�b�N�ɓ���Ă����
# cd �̂��Ƃ�Tab�����������ŗ���\�����Ă����
setopt auto_pushd

# �f�B���N�g���X�^�b�N�ɂ��łɓ����Ă���f�B���N�g���̓X�^�b�N���Ȃ�
setopt pushd_ignore_dups

# ���@�\�ȃ��C���h�J�[�h�W�J��L��
setopt extended_glob

# �v�����v�g������Ŋe��W�J���s�Ȃ�
setopt prompt_subst

# ���s�R�[�h�ŏI��Ȃ��o�͂������Əo�͂���
setopt no_promptcr

# Ctrl-D �Ń��O�A�E�g����̂�}������B
setopt  ignore_eof

# �O���u���}�b�`���Ȃ��Ƃ��G���[�ɂ��Ȃ�
# http://d.hatena.ne.jp/amt/20060806/ZshNoGlob
setopt null_glob

# �h�b�g�𖾎����Ȃ��Ă��h�b�g�t�@�C���Ƀ}�b�`
setopt globdots

########################################
# �R�}���h����T��
########################################
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

########################################
# �v�����v�g�̕\���ݒ�
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
# VCS�֘A�̕\���ݒ�
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
