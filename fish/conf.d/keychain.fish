if status is-login
    and status is-interactive

    for key in $SSH_KEYS_TO_AUTOLOAD
        set -l temp_output (keychain --quiet --eval $key 2>/dev/null)
    end
end
