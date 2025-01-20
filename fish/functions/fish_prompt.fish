set -U fish_prompt_git_status_added '✚'
set -U fish_prompt_git_status_modified '*'
set -U fish_prompt_git_status_renamed '➜'
set -U fish_prompt_git_status_deleted '✖'
set -U fish_prompt_git_status_unmerged '═'
set -U fish_prompt_git_status_untracked '.'

function prompt_dir -d "Display the current directory"
    prompt_segment $color_dir_bg $color_dir_str (prompt_pwd)
end

function prompt_finish -d "Close open segments"
    if [ -n $current_bg ]
        set_color normal
        set_color $current_bg
        echo -n "$segment_separator "
        set_color normal
    end
    set -g current_bg NONE

    echo "
> "
end

function prompt_git -d "Display the current git state"
    set -l branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)
    if test -z $branch
        return
    end

    set -l index (git status --porcelain 2>/dev/null)
    if test -z "$index"
        prompt_segment $color_git_bg $color_git_str
        printf $branch' ✓'
        set_color normal
        return
    end

    git diff-index --quiet --cached HEAD 2>/dev/null
    set -l staged $status
    if test $staged = 1
        prompt_segment $fish_color_git_staged $color_git_str
        set_color -b $fish_color_git_staged
    else
        prompt_segment $fish_color_git_dirty $color_git_str
        set_color -b $fish_color_git_dirty
    end

    set -l info
    for i in $index
        switch $i
            case 'A  *'
                set i added
            case 'M  *' ' M *'
                set i modified
            case 'R  *'
                set i renamed
            case 'D  *' ' D *'
                set i deleted
            case 'U  *'
                set i unmerged
            case '?? *'
                set i untracked
        end

        if not contains $i $info
            set info $info $i
        end
    end


    eval 'set_color $color_git_str'
    printf $branch' '

    for i in added modified renamed deleted unmerged untracked
        if contains $i $info
            # eval 'set_color -b $fish_color_git_'$i

            # This eval will print a symbol or text specific to each git status type.
            eval 'printf $fish_prompt_git_status_'$i
        end
    end


    printf ' '

    set_color normal
end

function prompt_segment -d "Function to draw a segment"
    set -l bg
    set -l fg
    if [ -n "$argv[1]" ]
        set bg $argv[1]
    else
        set bg normal
    end
    if [ -n "$argv[2]" ]
        set fg $argv[2]
    else
        set fg normal
    end
    if [ "$current_bg" != NONE -a "$argv[1]" != "$current_bg" ]
        set_color -b $bg
        set_color $current_bg
        echo -n "$segment_separator "
        set_color -b $bg
        set_color $fg
    else
        set_color -b $bg
        set_color $fg
        echo -n " "
    end
    set current_bg $argv[1]
    if [ -n "$argv[3]" ]
        echo -n -s $argv[3] " "
    end
end

function prompt_status -d "the symbols for a non zero exit status, root and background jobs"
    if [ $RETVAL -ne 0 ]
        prompt_segment $color_status_nonzero_bg $color_status_nonzero_str "✘"
    end

    if [ "$fish_private_mode" ]
        prompt_segment $color_status_private_bg $color_status_private_str "🔒"
    end

    # if superuser (uid == 0)
    set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
        prompt_segment $color_status_superuser_bg $color_status_superuser_str "⚡"
    end

    # Jobs display
    if [ (jobs -l | wc -l) -gt 0 ]
        prompt_segment $color_status_jobs_bg $color_status_jobs_str "⚙"
    end
end

function prompt_user -d "Display current user if different from $default_user"
    if [ "$theme_display_user" = yes ]
        if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
            set USER (whoami)
            get_hostname
            if [ $HOSTNAME_PROMPT ]
                set USER_PROMPT $USER@$HOSTNAME_PROMPT
            else
                set USER_PROMPT $USER
            end
            prompt_segment $color_user_bg $color_user_str $USER_PROMPT
        end
    else
        get_hostname
        if [ $HOSTNAME_PROMPT ]
            prompt_segment $color_user_bg $color_user_str $HOSTNAME_PROMPT
        end
    end
end

function fish_prompt
    set -g RETVAL $status
    prompt_status
    # prompt_virtual_env
    prompt_user
    prompt_dir
    if [ (cwd_in_scm_blacklist | wc -c) -eq 0 ]
        type -q git; and prompt_git
        if [ "$theme_hg_prompt_enabled" = yes ]
            type -q hg; and prompt_hg
        end
    end
    prompt_finish
end
