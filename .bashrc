# ~/.BASH_RC FILE

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# -------------
# Colour scheme settings
# -------------
# Set color scheme
export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[0;35m\]\h\[\e[m\] \[\e[0;33m\]\W\[\e[m\] \[\e[0;37m\]\$\[\e[m\] \[\e[0;36m'

# -------------
# History search binding
# -------------
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# -------------
# Set custom env variables
# -------------
if [ -f ./.bashrc_custom_env ]; then
    source ./.bashrc_custom_env
fi

# -------------
# Aliases
# -------------
# Common aliases to prevent clobbering files.
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ..='cd ..'
alias h='history'
alias ll='ls -l'

alias py='python3'
alias py2='python'
alias py3='python3'

alias sublime='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# Other aliases
alias reset_bash='source ~/.bashrc'
alias reload_inputrc='source ~/.inputrc'
alias xterm='xterm -rv &'
alias show_hidden_files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide_hidden_files='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# -------------
# History and autocomplete settings
# -------------
export HISTTIMEFORMAT='%F %T ' # add timestamp to history command display
export HISTSIZE=5000 # set history size
export HISTCONTROL=erasedups # ignore duplicates
export HISTIGNORE="pwd:ls:cd:ll:bg:fg:history:h" # ignore basic commands

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # save each command to history after is has been executed

shopt -s histappend # append history instead of overwriting

# -------------
# Functions
# -------------
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function extract_all()
{
  for f in *
  do
    echo $f
    extract $f
  done

}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar czf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Creates an archive (*.tar.gz) from given directory.
function maketar_v() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Set terminal title
function set_title()
{
  export PROMPT_COMMAND_SAVED=$PROMPT_COMMAND
  export PROMPT_COMMAND="history -a" # remove title autoupdate
  echo -ne "\033]0;$1\007" # set title
}

# Revert terminal title
function revert_title()
{
  export PROMPT_COMMAND=$PROMPT_COMMAND_SAVED # restore PROMPT_COMMAND
}

# USEFUL BASH HOTKEYS
#
# Ctrl + A  Go to the beginning of the line you are currently typing on
# Ctrl + E  Go to the end of the line you are currently typing on
# Ctrl + L  Clears the Screen, similar to the clear command
# Ctrl + U  Clears the line before the cursor position. If you are at the end of the line, clears the entire line.
# Ctrl + H  Same as backspace
# Ctrl + R  Let’s you search through previously used commands
# Ctrl + C  Kill whatever you are running
# Ctrl + D  Exit the current shell
# Ctrl + Z  Puts whatever you are running into a suspended background process. fg restores it.
# Ctrl + W  Delete the word before the cursor
# Ctrl + K  Clear the line after the cursor
# Ctrl + T  Swap the last two characters before the cursor
# Esc + T Swap the last two words before the cursor
# Alt + F Move cursor forward one word on the current line
# Alt + B Move cursor backward one word on the current line
