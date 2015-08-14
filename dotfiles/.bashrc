# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over ridden in every subshell.
# ctrl-x-e to edit a long command in vi mode, can also set it to emacs
export EDITOR=/usr/bin/vim

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

HISTSIZE=10000

test -s ~/.alias && . ~/.alias || true

export JAVA_HOME=/usr/lib64/jvm/java
export SCALA_HOME=/opt/scala
export PATH=$PATH:/opt/scala/bin

[[ -d ~/logssh ]] || mkdir ~/logssh
function logssh() {
    logfile=$*
    logfile=${logfile##*@}              #get substring after last @
    logfile=${logfile%% *}              #get substring before first whitespace
    logfile="${logfile}_$(date +'%F_%R')"
    ssh $* 2>&1 | tee ~/logssh/${logfile}.log
}
