function cwd_in_scm_blacklist
    for entry in $scm_prompt_blacklist
        pwd | grep "^$entry" -
    end
end
