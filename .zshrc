source /opt/homebrew/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle macos
antigen theme ys
antigen apply

unsetopt share_history

export ANDROID_HOME=$HOME/Library/Android/sdk
export PREFIX=~/.n
export N_PREFIX=~/.n
export PATH=$PREFIX/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/opt/homebrew/opt/python@3.9/libexec/bin

export FPATH=$FPATH:/opt/homebrew/share/zsh/site-functions

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:/Users/kumail/Dev/depot_tools
export PATH=$PATH:/Users/kumail/.cargo/bin

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source ~/.credentials

alias rg="rg -M 1024"
alias gt-merge-without-approval="gh pr merge -s --admin && gt up && gt sync && gt submit --no-stack --no-interactive"
alias gt-modify-and-submit="gt modify && gt submit"
alias ga2-full-sync="gt sync && yarn && ga2 db:migrate"
alias docker-compose="docker compose"

VIRTUAL_ENV_DISABLE_PROMPT=1 source ~/Dev/global_venv/bin/activate

eval "$(rbenv init - zsh)"

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: /opt/homebrew/bin/gt completion >> ~/.zshrc
#    or /opt/homebrew/bin/gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

GATHER_AC_ZSH_SETUP_PATH=/Users/kumail/Library/Caches/gather-cli/autocomplete/zsh_setup && test -f $GATHER_AC_ZSH_SETUP_PATH && source $GATHER_AC_ZSH_SETUP_PATH; # gather autocomplete setup

# bun completions
[ -s "/Users/kumail/.bun/_bun" ] && source "/Users/kumail/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# unsetopt share_history
# unsetopt inc_append_history

# HISTFILE_BASE=~/.zsh_history_tabs/iterm_
# HISTFILE_TEMP=~/.zsh_history_tabs/tmp_$$
# HISTFILE_TERM=~/.zsh_history_tabs/iterm_$ITERM_SESSION_ID
# HISTFILE_GLOB=~/.zsh_history

# Generate a unique but persistent file name based on iTerm session ID
# if [[ -n "$ITERM_SESSION_ID" ]]; then
#    export HISTFILE=$HISTFILE_TERM

    # For new terminals, create histfile by combination of all tabs
#    if [[ ! -f "$HISTFILE" && -f "$HISTFILE_GLOB" ]]; then
#        cp "$HISTFILE_GLOB" "$HISTFILE_TEMP"
#        tail -n30000 ${HISTFILE_BASE}* >> "$HISTFILE_TEMP" 2>/dev/null
#        mv $HISTFILE_TEMP $HISTFILE
#    fi
#else
#    export HISTFILE=$HISTFILE_GLOB
#fi
export AWS_PROFILE="infra"

aws-login () {
  AWS_PROFILE=${1:-$AWS_PROFILE} \
  && echo "AWS_PROFILE=${AWS_PROFILE}" \
  && aws sso login --profile "${AWS_PROFILE}" \
  && eval $(aws configure export-credentials --format env --profile "${AWS_PROFILE}") \
  && (aws sts get-caller-identity --output json --profile "${AWS_PROFILE}" | cat)
}

# Added by Windsurf
export PATH="/Users/kumail/.codeium/windsurf/bin:$PATH"

# Claude Code alias
print_box() {
  local text="$1"
  local border="┃"
  local width=$(( ${#text} + 4 ))
  local top="┏${(l:$width::━:)}┓"
  local bottom="┗${(l:$width::━:)}┛"
  local white=$'\033[97m'
  local blue=$'\033[34m'
  local reset=$'\033[0m'

  echo -e "${blue}${top}"
  echo -e "${border} ${white}$text${blue} ${border}"
  echo -e "${bottom}${reset}"
}
ai() {
  command=$(amp -x "tell me the cli one-liner for the following with ABSOLUTELY NO formatting or extra words such that it can be directly pasted into a terminal and run: $*")
  print_box "$command"
  read -q "REPLY?Run command? [y/N] " && eval "$command"
}

alias kube-ai-services="kubectl -n grapevine-services"
alias kube-ai-workers="kubectl -n grapevine-workers"
alias awslocal="AWS_ENDPOINT_URL=http://localhost:4566 aws"

. "$HOME/.local/bin/env"

eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

eval "$(mise activate --shims zsh)"
