function get_hostname -d "Set current hostname to prompt variable $HOSTNAME_PROMPT if connected via SSH"
    set -g HOSTNAME_PROMPT ""
    if [ "$theme_hide_hostname" = no -o \( "$theme_hide_hostname" != yes -a -n "$SSH_CLIENT" \) ]
        # set -g HOSTNAME_PROMPT (uname -n | string replace ".local" "" | string replace "domain" "")
        # set -g HOSTNAME_PROMPT (uname -n | string replace ".local" "" | string replace "domain" "" | sed 's/-[0-9]\+$//')
        set -g HOSTNAME_PROMPT (uname -n | string replace ".local" "" | string replace "domain" "" | string replace "-" "" | string replace "1" "" | string replace "2" "" | string replace "3" "" | string replace "4" "" | string replace "5" "" | string replace "6" "" | string replace "7" "" | string replace "8" "" | string replace "9" "")
    end
end
