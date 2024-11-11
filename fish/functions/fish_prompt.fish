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
