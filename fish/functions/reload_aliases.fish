function reload_aliases -d "Reload aliases"
    if [ -f ~/.aliases ]
        . ~/.aliases
    end

    if [ -f ~/.dotfiles/aliases ]
        . ~/.dotfiles/aliases
    end
end
