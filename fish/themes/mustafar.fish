# ===========================
# Color setting
# ===========================

# Core Colors
set -g color_dir_bg '#2A0000' # Dark red-brown for directory background
set -g color_dir_str '#FFA500' # Lava orange for directory text
set -g color_user_str '#FFA500' # Lava orange for user text

# Backgrounds
set -g current_bg NONE # Transparent background for consistency
set -g segment_separator \uE0B0 # Default segment separator
set -g right_segment_separator \uE0B0

# Virtual Environment
set -q color_virtual_env_bg; or set color_virtual_env_bg '#3C1F1F' # Dark red-brown
set -q color_virtual_env_str; or set color_virtual_env_str '#FFA500' # Lava orange

# User Backgrounds
set -q color_user_bg; or set color_user_bg '#3C1F1F' # Dark red for contrast with orange
set -q color_user_str; or set color_user_str '#FFA500' # Lava orange

# Directory Colors
set -q color_dir_bg; or set color_dir_bg '#3C1F1F' # Dark volcanic red
set -q color_dir_str; or set color_dir_str '#FFA500' # Bright lava orange for readability

# Repository States (like Git and Mercurial)
set -q color_hg_changed_bg; or set color_hg_changed_bg '#FFD700' # Fiery yellow for changes
set -q color_hg_changed_str; or set color_hg_changed_str '#3C1F1F' # Dark red for contrast
set -q color_hg_bg; or set color_hg_bg '#FF4500' # Bright orange-red to reflect lava
set -q color_hg_str; or set color_hg_str '#3C1F1F' # Dark text for visibility
set -q color_git_dirty_bg; or set color_git_dirty_bg '#FFD700' # Fiery yellow
set -q color_git_dirty_str; or set color_git_dirty_str '#3C1F1F'
set -q color_git_bg; or set color_git_bg '#FF4500'
set -q color_git_str; or set color_git_str '#3C1F1F'
set -q color_svn_bg; or set color_svn_bg '#FF4500'
set -q color_svn_str; or set color_svn_str '#3C1F1F'

# Status Indicators
set -q color_status_nonzero_bg; or set color_status_nonzero_bg '#3C1F1F' # Dark red for failed status
set -q color_status_nonzero_str; or set color_status_nonzero_str '#FF6347' # Soft red for errors
set -q color_status_superuser_bg; or set color_status_superuser_bg '#3C1F1F'
set -q color_status_superuser_str; or set color_status_superuser_str '#FFD700' # Fiery yellow for elevated status
set -q color_status_jobs_bg; or set color_status_jobs_bg '#3C1F1F'
set -q color_status_jobs_str; or set color_status_jobs_str '#FF4500' # Bright orange-red for background tasks
set -q color_status_private_bg; or set color_status_private_bg '#3C1F1F'
set -q color_status_private_str; or set color_status_private_str '#800000' # Dark maroon for private status
