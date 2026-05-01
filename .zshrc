export PATH=/opt/homebrew/opt/llvm/bin:$PATH

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey -e
bindkey ' ' magic-space

chpwd() {
	clear
	ls
}

alias vim="nvim"

alias -s cpp="$EDITOR"
alias -s hpp="$EDITOR"

alias -s c="$EDITOR"
alias -s h="$EDITOR"

alias -s md="$EDITOR"

alias -g C="| pbcopy"

eval "$(zoxide init zsh --cmd cd)"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH=$PATH:$HOME/go/bin

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
