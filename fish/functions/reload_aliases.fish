function reload_aliases -d "Reload aliases"
    if [ -f ~/.aliases ]
        . ~/.aliases
    end

    if [ -f ~/.dotfiles/aliases ]
        . ~/.dotfiles/aliases
    end

    switch (uname -s)
        case Linux
            if [ -f ~/.dotfiles/aliases_linux ]
                . ~/.dotfiles/aliases_linux
            end
        case Darwin
            if [ -f ~/.dotfiles/aliases_osx ]
                . ~/.dotfiles/aliases_osx
            end
    end
end
