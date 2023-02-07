# Aliases
alias reload!='. ~/.zshrc'
alias vim=nvim
alias sshconf='vim ~/.ssh/config'
alias dotfiles='vim -c "cd ~/.dotfiles" ~/.dotfiles'
alias ll="ls -alh"
alias cmd="navi --print | pbcopy"
alias notes="~/vendor/standard-notes-3.5.18-linux-x86_64.AppImage"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias showpath="tr ':' '\n' <<< "$PATH""
