[[ $- != *i* ]] && return

 # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh//.zshrc.
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi

 typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

 source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

 # Customize Prompt
 [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

 # load aliasrc if exist
 [ -f "${ZDOTDIR}/aliasrc" ] && source "${ZDOTDIR}/aliasrc"

 # load optionrc if exist
 [ -f "${ZDOTDIR}/optionrc" ] && source "${ZDOTDIR}/optionrc"

 # Completion
 autoload -Uz compinit; compinit -i
 source "${ZDOTDIR}/completion.zsh"

 # Plugins
 source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
 source "${ZDOTDIR}/plugins/f-sy-h/F-Sy-H.plugin.zsh"
 source "${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
 source "${ZDOTDIR}/plugins/zoxide/zoxide.plugin.zsh"
 source "${ZDOTDIR}/plugins/colorize/colorize.plugin.zsh"
 

 # Lines configured by zsh-newuser-install
 HISTFILE=~/.cache/zsh/history
 HISTSIZE=11000
 SAVEHIST=10000

 zmodload zsh/terminfo
 bindkey "$terminfo[kcuu1]" history-substring-search-up
 bindkey "$terminfo[kcud1]" history-substring-search-down
 bindkey '^[[A' history-substring-search-up
 bindkey '^[OA' history-substring-search-up
 bindkey '^[[B' history-substring-search-down
 bindkey '^[OB' history-substring-search-down												 # tab completion
 zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'           # Case                insensitive tab completion
 zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"                                  # Colored             completion (different colors for dirs/files/etc)
 zstyle ':completion:*' rehash true                                                          # automatically       find new executables in path
 zstyle ':completion:*' menu select                                                          # Highlight menu      selection

# Funcnest
export FUNCNEST="1000"

# Fzf
 eval "$(fzf --zsh)"

 # Zoxide
 eval "$(zoxide init zsh)"

 # Yazi
 export EDITOR="nvim"

  function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
