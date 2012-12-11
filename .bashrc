# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
	#. /etc/bashrc
#fi

# User specific aliases and functions

export PS1='\[\033[01;35m\]\u@\h \[\033[01;34m\]\w \$ \[\033[00m\]'

#export PS1="\u@\h:\w$ "
export HISTFILE=~/.bash_history
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL=ignorespace:ignoredups:erasedups

#
# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob      # Necessary for programmable completioa

shopt -s cmdhist



alias ..='cd ..'
alias ~='cd ~'

#export LANG=POSIX
#export LC_CTYPE=it_CH.ISO_8859-1

# color setting 
#export CLICOLOR=1
export LSCOLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
#alias ll='ls -AlrtF --color=auto'
alias ll='ls -lrtB --color=auto'
alias sudo='A=`alias` sudo '

# group writeable
umask 002

# Slove sudo auto complete
complete -f "sudo vim"
#complete -cf sudo

case "$TERM" in
    xterm*|rxvt*)
        # get history via up/down
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
        ;;
esac

# sudo complete hostname for ssh command
# @see http://bit.ly/p7VNs6
if [ -d ~/.ssh/known_hosts ]; then
    complete -W "$(while IFS=' ,' read host t; do echo $host; done < ~/.ssh/known_hosts)" ssh
fi

agent_file=/tmp/ssh-agent-$USER.sock

if [ "$SSH_TTY" -a "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != $agent_file ]; then
    ln -sfn $SSH_AUTH_SOCK $agent_file
    export SSH_AUTH_SOCK=$agent_file
fi

netstat_tcp_connections ()
{
	netstat -an --tcp  | awk 'NR > 2 {print $NF}' | sort | uniq -c | sort \
        -k1 -n -r
}

update_ssh_agent() {
    for sock in /tmp/ssh-*/agent*
    do
        if [ -S $sock ]; then
            ln -sfn $sock $agent_file
        fi
    done
}
