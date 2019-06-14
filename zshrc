# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:/usr/local/bin:$PATH

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(autojump bgnotify cargo docker-compose docker fzf-zsh git golang httpie kubectl rust vi-mode zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir custom_kubectl rbenv vcs virtualenv background_jobs vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
POWERLEVEL9K_VI_INSERT_MODE_STRING="\u270e"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="\u2605"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "
POWERLEVEL9K_CUSTOM_KUBECTL="kubectl config current-context"

# https://github.com/bhilburn/powerlevel9k/issues/319
function zle-line-init {
    powerlevel9k_prepare_prompts
    if (( ${+terminfo[smkx]}  )); then
        printf '%s' ${terminfo[smkx]}
    fi
    zle reset-prompt
    zle -R
}

function zle-line-finish {
    powerlevel9k_prepare_prompts
    if (( ${+terminfo[rmkx]}  )); then
        printf '%s' ${terminfo[rmkx]}
    fi
    zle reset-prompt
    zle -R
}

function zle-keymap-select {
    powerlevel9k_prepare_prompts
    zle reset-prompt
    zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
### End https://github.com/bhilburn/powerlevel9k/issues/319

# Make M-. work in vi insert mode
bindkey -M viins '\e.' insert-last-word
# Make push-line work in vi insert mode
bindkey -M viins '\eq' push-line
# Make a hybrid mode by adding some emacs bindings back
bindkey -M viins '^d' delete-char
bindkey -M viins '\ed' delete-word
bindkey -M viins '^b' backward-char
bindkey -M viins '^f' vi-forward-char
bindkey -M viins '\ef' vi-forward-word
bindkey -M viins '\eb' vi-backward-word
bindkey -M viins '^k' kill-line

bindkey -M viins '^T' fzf-file-widget
bindkey -M viins '\ec' fzf-cd-widget
bindkey -M viins '^R' fzf-history-widget

# 10ms for key sequences
export KEYTIMEOUT=1

# Activate extra completions
autoload -U compinit && compinit

# bare `cd` to a directory under here will work
setopt auto_cd
cdpath=($HOME/devel)

# Don't share history between sessions
setopt nosharehistory
# Remove old entries if new one is a duplicate
setopt HIST_IGNORE_ALL_DUPS

export EDITOR=vim

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

function tardiff() {
    diff -u <(tar -v -tf $1) <(tar -v -tf $2)
}