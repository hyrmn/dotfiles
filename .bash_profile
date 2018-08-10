eval "$(scmpuff init -s)"

function git() {
  case $1 in
    commit|blame|log|rebase|merge)
      eval "$SCMPUFF_GIT_CMD" "$(cygpath -u -- $(scmpuff expand --  "$@") | tr '\n' ' ')";;
    checkout|diff|rm|reset)
      eval "$SCMPUFF_GIT_CMD" "$(cygpath -u -- $(scmpuff expand --relative --  "$@") | tr '\n' ' ')";;
    add)
      eval "$SCMPUFF_GIT_CMD" "$(cygpath -u -- $(scmpuff expand --  "$@") | tr '\n' ' ')"
      scmpuff_status;;
    *)
      "$SCMPUFF_GIT_CMD" "$@";;
  esac
}

alias g='git'
alias get='git'

alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'

alias gco='git checkout'
alias gcob='git checkout -b'
alias gf='git fetch --all --prune'

alias gls='git log --format=format:"%C(bold yellow)%h %C(reset) %s %C(green) [%an] %C(reset)" --decorate'
alias gll='git log --pretty=format:"%C(bold yellow)%h %C(reset) %s %C(green) [%an] %C(reset)" --decorate --numstat'
alias glg1='git log --graph --format=format:"%C(bold yellow)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --abbrev-commit --date=relative'
alias glg2='git log --graph --format=format:"%C(bold yellow)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''%C(white)%s%C(reset) %C(bold white)- %an%C(reset)" --abbrev-commit'
alias glg='glg1'

alias gsave='git stash save'
alias gpop='git stash pop --index'
alias gsp='git push --force-with-lease'

npp() {
	notepad++.exe $* &
}

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"