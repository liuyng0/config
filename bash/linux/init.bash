# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export CONFIG_ROOT_DIR=$(dirname $(dirname $(dirname `realpath ${BASH_SOURCE[0]}`)))

source ${CONFIG_ROOT_DIR}/bash/common/pre.bash
source-pre-bashes
source-other-bashes
source-post-bashes

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#enable bash completion in interactive shells
if ! shopt -oq posix; then
   if [ -f /usr/share/bash-completion/bash_completion ]; then
       . /usr/share/bash-completion/bash_completion
   elif [ -f /etc/bash_completion ]; then
       . /etc/bash_completion
   fi
fi

append-to-path "$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

head-to-path "~/.emacs-pkg"
append-to-path "~/bin:~/bin/binfile:~/bin/common-scripts:~/bin/common-scripts/envs:~/bin/private-scripts"

# import some repo variables
#. ~/envsetup/repo-vars

append-to-variable INFOPATH "/usr/local/texlive/2015/texmf-dist/doc/info"
append-to-variable MANPATH "/usr/local/texlive/2015/texmf-dist/doc/man"
append-to-path "/usr/local/texlive/2015/bin/x86_64-linux:/sbin:/usr/sbin:/usr/share-2/bin"
append-to-path "~/bin/common-scripts/android-decompile"
append-to-path "~/build/android-studio/bin"

export USE_CCACHE=1
export CCACHE_DIR=/local/ccache

head-to-path "~/.platform_script"

if [ $TERM == "eterm-color" ]; then
    export PATH=${PATH//\/home\/local\/ANT\/ayliu\/software\/jdk1.8.0_91\/\/bin://}
fi

unset JAVA_HOME

append-to-path "~/software/racket/bin/"
append-to-path "~/software/swift-dev/bin"

alias repo-init-android-o='repo init -u https://aosp.tuna.tsinghua.edu.cn/platform/manifest -b android-8.0.0_r13'
alias export-repo-url='export REPO_URL=https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/ && export PATH=~/.platform_script/tsinghua-mirror-repo:$PATH'

append-to-path "~/git-repo/depot_tools"
append-to-variable LD_LIBRARY_PATH "$HOME/bin/lib"
append-to-variable MANPATH "~/git-repo/depot_tools/man/"
