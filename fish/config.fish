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

# ===========================
# Color setting

# You can set these variables in config.fish like:
# set -g color_dir_bg red
# If not set, default color from agnoster will be used.
# ===========================

# Core Colors
set -g color_dir_bg '#E0E9F4' # Icy blue-white for directory background
set -g color_dir_str '#333F4D' # Dark gray for directory text (for contrast)
set -g color_user_str '#E0E9F4' # Icy blue-white for user text

# Backgrounds
set -g current_bg NONE # Keep as transparent/none to fit the Hoth theme
set -g segment_separator \uE0B0 # Default separator
set -g right_segment_separator \uE0B0

# Virtual Environment
set -q color_virtual_env_bg; or set color_virtual_env_bg '#D6E6F0' # Light frosty blue
set -q color_virtual_env_str; or set color_virtual_env_str '#333F4D' # Dark gray

# User Backgrounds
set -q color_user_bg; or set color_user_bg '#333F4D' # Darker gray to give icy white contrast
set -q color_user_str; or set color_user_str '#D6E6F0' # Frosty blue-white

# Directory Colors
set -q color_dir_bg; or set color_dir_bg '#A9C0DA' # Soft, light blue to feel cold
set -q color_dir_str; or set color_dir_str '#333F4D' # Dark gray for readability

# Repository States (like Git and Mercurial)
set -q color_hg_changed_bg; or set color_hg_changed_bg '#E6E1A9' # Pale yellow, hints at snow disturbance
set -q color_hg_changed_str; or set color_hg_changed_str '#333F4D' # Dark gray text
set -q color_hg_bg; or set color_hg_bg '#91B3E1' # Calm, icy blue
set -q color_hg_str; or set color_hg_str '#333F4D' # Dark gray text
set -q color_git_dirty_bg; or set color_git_dirty_bg '#E6E1A9' # Same pale yellow as Mercurial
set -q color_git_dirty_str; or set color_git_dirty_str '#333F4D'
set -q color_git_bg; or set color_git_bg '#91B3E1'
set -q color_git_str; or set color_git_str '#333F4D'
set -q color_svn_bg; or set color_svn_bg '#91B3E1'
set -q color_svn_str; or set color_svn_str '#333F4D'

# Status Indicators
set -q color_status_nonzero_bg; or set color_status_nonzero_bg '#333F4D' # Dark gray for failed status
set -q color_status_nonzero_str; or set color_status_nonzero_str '#E6B1B1' # Soft red for errors
set -q color_status_superuser_bg; or set color_status_superuser_bg '#333F4D'
set -q color_status_superuser_str; or set color_status_superuser_str '#E6E1A9' # Hint of yellow for elevated status
set -q color_status_jobs_bg; or set color_status_jobs_bg '#333F4D'
set -q color_status_jobs_str; or set color_status_jobs_str '#91B3E1' # Cool icy blue for background tasks
set -q color_status_private_bg; or set color_status_private_bg '#333F4D'
set -q color_status_private_str; or set color_status_private_str '#B6A7E6' # Soft purple, subtle and cold



if status is-interactive
    # Commands to run in interactive sessions can go here
end

reload_aliases
