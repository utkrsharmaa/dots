#!/usr/bin/env fish
set fish_greeting

# Make skim do the right thing by default
set -x SKIM_DEFAULT_COMMAND "fd --type f"

# Rust
# Ensure that Cargo binaries are in the PATH
set PATH $HOME/.cargo/bin/ $PATH

# Helpful expansions
abbr -a -g gp git push
abbr -a -g gc git commit -asm
abbr -a -g gst git status

# Helpful aliases
command -q exa; and alias la="exa -abghl --git --color=automatic"
command -q exa; and alias ll="exa -bghl --git --color=automatic"

# Fisher!
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# add to ~/.config/fish/config.fish
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
