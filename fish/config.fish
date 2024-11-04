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

# ===========================
# Color setting

# You can set these variables in config.fish like:
# set -g color_dir_bg red
# If not set, default color from agnoster will be used.

set -g color_dir_bg red
set -g color_dir_str white
set -g color_user_str white

set -g current_bg NONE
set segment_separator \uE0B0
set right_segment_separator \uE0B0
set -q scm_prompt_blacklist; or set scm_prompt_blacklist

set -q color_virtual_env_bg; or set color_virtual_env_bg white
set -q color_virtual_env_str; or set color_virtual_env_str black
set -q color_user_bg; or set color_user_bg black
set -q color_user_str; or set color_user_str yellow
set -q color_dir_bg; or set color_dir_bg blue
set -q color_dir_str; or set color_dir_str black
set -q color_hg_changed_bg; or set color_hg_changed_bg yellow
set -q color_hg_changed_str; or set color_hg_changed_str black
set -q color_hg_bg; or set color_hg_bg green
set -q color_hg_str; or set color_hg_str black
set -q color_git_dirty_bg; or set color_git_dirty_bg yellow
set -q color_git_dirty_str; or set color_git_dirty_str black
set -q color_git_bg; or set color_git_bg green
set -q color_git_str; or set color_git_str black
set -q color_svn_bg; or set color_svn_bg green
set -q color_svn_str; or set color_svn_str black
set -q color_status_nonzero_bg; or set color_status_nonzero_bg black
set -q color_status_nonzero_str; or set color_status_nonzero_str red
set -q color_status_superuser_bg; or set color_status_superuser_bg black
set -q color_status_superuser_str; or set color_status_superuser_str yellow
set -q color_status_jobs_bg; or set color_status_jobs_bg black
set -q color_status_jobs_str; or set color_status_jobs_str cyan
set -q color_status_private_bg; or set color_status_private_bg black
set -q color_status_private_str; or set color_status_private_str purple

# ===========================
# Git settings
# set -g color_dir_bg red

set -q fish_git_prompt_untracked_files; or set fish_git_prompt_untracked_files normal

# ===========================
# Subversion settings

set -q theme_svn_prompt_enabled; or set theme_svn_prompt_enabled no

if status is-interactive
    # Commands to run in interactive sessions can go here
end
