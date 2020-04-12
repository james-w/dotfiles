# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:/usr/local/bin:$PATH

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir kubecontext rbenv virtualenv vcs background_jobs newline time prompt_char)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time history time newline)
# Show prompt segment "kubecontext" only when the command you are typing
# invokes kubectl, helm, kubens, kubectx, oc, istioctl or kogito.
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito'

typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

# Add an empty line before each prompt except the first. This doesn't emulate the bug
# in Pure that makes prompt drift down whenever you use the Alt-C binding from fzf or similar.
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Prompt colors.
local grey='242'
local red='1'
local yellow='3'
local blue='4'
local magenta='5'
local cyan='6'
local white='7'

# Magenta prompt symbol if the last command succeeded.
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$magenta
# Red prompt symbol if the last command failed.
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$red
# Default prompt symbol.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
# Prompt symbol in command vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
# Prompt symbol in visual vi mode is the same as in command mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='❮'
# Prompt symbol in overwrite vi mode is the same as in command mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

# Grey Python Virtual Environment.
typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$grey
# Don't show Python version.
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

# Blue current directory.
typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue

# Context format when root: user@host. The first part white, the rest grey.
typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%f%F{$grey}@%m%f"
# Context format when not root: user@host. The whole thing grey.
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
# Don't show context unless root or in SSH.
typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

# Show previous command duration only if it's >= 1s.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
# Show fractional seconds
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
# Duration format: 1d 2h 3m 4s.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
# Yellow previous command duration.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow

# Grey Git prompt. This makes stale prompts indistinguishable from up-to-date ones.
typeset -g POWERLEVEL9K_VCS_FOREGROUND=$grey

# Don't wait for Git status even for a millisecond, so that prompt always updates
# asynchronously when Git state changes.
typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

# Disable async loading indicator to make directories that aren't Git repositories
# indistinguishable from large Git repositories without known state.
typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=

# Cyan ahead/behind arrows.
typeset -g POWERLEVEL9K_VCS_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=$cyan
# Don't show remote branch, current tag or stashes.
typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)
# Don't show the branch icon.
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
# When in detached HEAD state, show @commit where branch normally goes.
typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
# Don't show staged, unstaged, untracked indicators.
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=
# Show '*' when there are staged, unstaged or untracked files.
typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
# Show '⇣' if local branch is behind remote.
typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=':⇣'
# Show '⇡' if local branch is ahead of remote.
typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=':⇡'
# Don't show the number of commits next to the ahead/behind arrows.
typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1
# Remove space between '⇣' and '⇡' and all trailing spaces.
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${${${P9K_CONTENT/⇣* :⇡/⇣⇡}// }//:/ }'

# Grey current time.
typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
# Format for the current time: 09:51:02. See `man 3 strftime`.
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
# If set to true, time will update when you hit enter. This way prompts for the past
# commands will contain the start times of their commands rather than the end times of
# their preceding commands.
typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

# tweak some colours to work better with Material theme
typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='004'
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND='001'

# Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
# when accepting a command line. Supported values:
#
#   - off:      Don't change prompt when accepting a command line.
#   - always:   Trim down prompt when accepting a command line.
#   - same-dir: Trim down prompt when accepting a command line unless this is the first command
#               typed after changing current working directory.
# Turn it off and implement it ourselves to preserve the timestamp
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
# Hide the time in the left prompt, but then show it in the old prompts.
# Hide the first line in old prompts.
# This combination is like transient mode, but keeping the timestamp
function p10k-on-pre-prompt() {
  # Show empty line unless it's the first prompt in the TTY.
  [[ $P9K_TTY == old ]] && p10k display 'empty_line'=show
  p10k display '1'=show '2/left/time'=hide
}
function p10k-on-post-prompt() { p10k display '1'=hide '2/left/time'=show 'empty_line'=hide }

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

export FZF_DEFAULT_OPTS='--height 40% --reverse'

function tardiff() {
    diff -u <(tar -v -tf $1) <(tar -v -tf $2)
}

export GOPATH=~/devel/gopath
export PATH=$PATH:$GOPATH/bin
