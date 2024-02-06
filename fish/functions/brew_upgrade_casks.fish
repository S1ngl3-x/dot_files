function brew_upgrade_casks
    for cask in (brew list --cask)
        brew upgrade $cask
    end
end
