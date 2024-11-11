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
