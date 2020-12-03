export FZF_DEFAULT_OPTS="--border --inline-info --height 40%"
export FZF_DEFAULT_COMMAND='rg --files --fixed-strings --no-ignore --hidden --follow --glob "!.git/*,!node_modules/*"'

_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv)
    if [[ $ARGS == 'git co'* ]]; then
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
