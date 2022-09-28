export FZF_DEFAULT_OPTS='--border --inline-info --height 40% --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export FZF_DEFAULT_COMMAND='rg --files --fixed-strings --no-ignore --hidden --follow --glob "!.git/*,!node_modules/*"'

_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv)
    if [[ $ARGS == 'git co'*  ||  $ARGS == 'git merge'* ]]; then
        _fzf_complete --reverse --multi -- "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

if [[ ! "$PATH" == */home/adrian/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/adrian/.fzf/bin"
fi

source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh

