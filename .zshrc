export JAVA_HOME=$(/usr/libexec/java_home -v 24.0.1)
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$HOME/scripts:$PATH
export PATH=/opt/homebrew/opt/llvm/bin:$PATH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U colors && colors

bindkey -e

# Aliases
alias a="source again.sh"
alias vim="nvim"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# History config
setopt INC_APPEND_HISTORY

# Zoxide config
eval "$(zoxide init zsh --cmd cd)"
