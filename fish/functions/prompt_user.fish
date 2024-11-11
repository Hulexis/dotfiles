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
