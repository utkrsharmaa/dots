function dot -w git -d "Manages dotfiles"
    git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $argv
end
