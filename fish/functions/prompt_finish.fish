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
