# if status is-login
#     and status is-interactive
#
#     for key in $SSH_KEYS_TO_AUTOLOAD
#         keychain --eval $key | source
#     end
# end

if status --is-interactive
    # keychain --quiet --agents ssh github

    for key in $SSH_KEYS_TO_AUTOLOAD
        keychain --quiet --eval $key | source
    end
end

begin
    set -l HOSTNAME (hostname)
    if test -f ~/.keychain/$HOSTNAME-fish
        source ~/.keychain/$HOSTNAME-fish
    end
end
