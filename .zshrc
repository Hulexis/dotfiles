# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


#ZSH_THEME="robbyrussell"


CASE_SENSITIVE="true"

plugins=(
	git
	branch
	tmux
	ubuntu
	npm
	frontend-search
	docker
	docker-compose
	composer
	keychain
	gulp
	ssh-agent
  zsh-autosuggestions
)

zstyle :omz:plugins:keychain agents gpg,ssh

source $ZSH/oh-my-zsh.sh
source ~/.zsh_profile

eval "$(starship init zsh)"

GOPATH=$HOME/go

zmodload zsh/datetime

function preexec() {
  __TIMER=$EPOCHREALTIME
}

# function powerline_precmd() {
#     	local __ERRCODE=$?
#   	local __DURATION=0
#
#   	if [ -n $__TIMER ]; then
#     		local __ERT=$EPOCHREALTIME
#     		__DURATION="$(($__ERT - ${__TIMER:-__ERT}))"
# 	fi
#     	eval "$($GOPATH/bin/powerline-go -error $? -shell zsh -eval -modules docker,venv,user,cwd,perms,git,exit,duration -duration $__DURATION -newline -hostname-only-if-ssh )"
# 	unset __TIMER
# }

# function install_powerline_precmd() {
#   for s in "${precmd_functions[@]}"; do
#     if [ "$s" = "powerline_precmd" ]; then
#       return
#     fi
#   done
#   precmd_functions+=(powerline_precmd)
# }
#
# if [ "$TERM" != "linux" ]; then
#     install_powerline_precmd
# fi

source ~/.zshenv
source ~/.zsh/aliases.zsh

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# base16_default

# ~/scripts/base-16.sh

. "$HOME/.cargo/env"

export DOTNET_ROOT=/snap/dotnet-sdk/current

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/arne/.cargo/bin
export PATH=$PATH:/opt/flutter/bin

export PATH="$PATH:/home/arne/custom/flutter/bin"
export PATH="$PATH:/home/arne/dev/flutter/sdk/bin"
export PATH="$PATH:/home/aj/.cargo/bin"
export PATH="$PATH:/usr/local/bin/flutter/bin"
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$GOPATH/bin"

export EDITOR=/usr/bin/nvim

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Load Angular CLI autocompletion.
# source <(ng completion script)

[ -f "/home/arne/.ghcup/env" ] && source "/home/arne/.ghcup/env" # ghcup-env


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# bun completions
[ -s "/home/aj/.bun/_bun" ] && source "/home/aj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
