set -U fish_user_paths $fish_user_paths $HOME/.local/bin/

# Definitions
set TERM screen-256color
set EDITOR vim
set VISUAL vim
# set BROWSER zen-browser
set BROWSER firefox-developer-edition

# Settings
set fish_greeting
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hg_prompt_enabled no
set -g theme_svn_prompt_enabled no
set -g fish_prompt_pwd_dir_length 0

set -q scm_prompt_blacklist; or set scm_prompt_blacklist

source ~/.config/fish/themes/hoth.fish
# source ~/.config/fish/themes/mustafar.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end


source ~/.zsh_profile

reload_aliases

set -x BUN_INSTALL "$HOME/.bun"
set -x GOPATH "$HOME/go"
set -x CARGO_PATH "$HOME/.cargo"

set -x PATH "$BUN_INSTALL/bin" $PATH
set -x PATH "$GOPATH/bin" $PATH
set -x PATH "$CARGO_PATH/bin" $PATH
