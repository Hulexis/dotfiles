set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_dirtystate '±'
set -g __fish_git_prompt_char_cleanstate ''

function parse_git_dirty
    if [ $__fish_git_prompt_showdirtystate = yes ]
        set -l submodule_syntax
        set submodule_syntax "--ignore-submodules=dirty"
        set untracked_syntax "--untracked-files=$fish_git_prompt_untracked_files"
        set git_dirty (command git status --porcelain $submodule_syntax $untracked_syntax 2> /dev/null)
        if [ -n "$git_dirty" ]
            echo -n "$__fish_git_prompt_char_dirtystate"
        else
            echo -n "$__fish_git_prompt_char_cleanstate"
        end
    end
end
