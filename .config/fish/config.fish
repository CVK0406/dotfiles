if status is-interactive
    # Starship custom prompt
    command -v starship &> /dev/null && starship init fish | source

    # Direnv + Zoxide
    command -v direnv &> /dev/null && direnv hook fish | source
    command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

    # Better ls
    command -v eza &> /dev/null && alias ls='eza --icons --group-directories-first -1'

    # Abbrs
    abbr lg 'lazygit'
    abbr gd 'git diff'
    abbr ga 'git add .'
    abbr gc 'git commit -am'
    abbr gl 'git log'
    abbr gs 'git status'
    abbr gst 'git stash'
    abbr gsp 'git stash pop'
    abbr gp 'git push'
    abbr gpl 'git pull'
    abbr gsw 'git switch'
    abbr gsm 'git switch main'
    abbr gb 'git branch'
    abbr gbd 'git branch -d'
    abbr gco 'git checkout'
    abbr gsh 'git show'

    abbr l 'ls'
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'

    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    # Custom fish config
    set -q XDG_CONFIG_HOME && set -l cConf $XDG_CONFIG_HOME/caelestia || set -l cConf $HOME/.config/caelestia
    source $cConf/user-config.fish 2> /dev/null
end
fish_add_path ~/.cargo/bin
alias matrix 'rusty-rain -s -g jap -C 30,110,200 -H white -S 10,180'
alias dotfiles 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

alias dots-sync 'pacman -Qqen > ~/dotfiles-export/pkglist.txt && pacman -Qqem > ~/dotfiles-export/aur-pkglist.txt && dotfiles add -u && dotfiles commit -m "sync $(date +%F)" && dotfiles push'


fnm env --use-on-cd | source
