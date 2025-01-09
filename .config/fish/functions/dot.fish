function dot -w git -d "Manages dotfiles"
    git --git-dir=$HOME/.dots/ --work-tree=$HOME $argv
end
