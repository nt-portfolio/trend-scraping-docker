#! /bin/bash

# ---------------------------
# Charset
# ---------------------------
export LANG=ja_JP.UTF-8

# ---------------------------
# Prompt display settings
# ---------------------------
# blue
PS1='\[\e[34m\]\u@\h \w \[\e[37m\]\$\[\e[0m\] '

# ---------------------------
# Alias
# ---------------------------
alias ls='/bin/ls --color=auto'
alias la='/bin/ls -lah --color=auto'
alias grep='/bin/grep --color=auto'
alias rm='/bin/rm -i'
alias mv='/bin/mv -i'
alias cp='/bin/cp -i'
alias ..='cd ..'
# alias cat='/bin/cat -n'

# ---------------------------
# Command
# ---------------------------
# # Move to vagrant data directory
# if [ -d "/vagrant_data" ]; then
#   cd /vagrant_data && ls -la
# fi

# ---------------------------
# Function
# ---------------------------
# n階層上のディレクトリへ移動する
# 参考: https://qiita.com/gdgd_gutta/items/39c5a289625f724f1752
# cdn n
function cdn(){
    if [ $# -eq 1 ]; then
        local temppath=`pwd`
        # ---------------------------
        # add 2020/03/18
        if [ $1 -ge 10 ]; then
           COUNT=10
        else
           COUNT=$1
        fi
        for i in `seq $COUNT`; do temppath=$temppath'/..'; done
        # ---------------------------
    cd $temppath
    else
        cd ../
    fi
    return 0
}

function sysinfo(){
    printf "\033[31m%s\033[m\n" '* System info'
    # Kernel
    uname -smr
    # OS
    DISTRI=( \
        "/etc/redhat-release" \
        "/etc/fedora-release" \
        "/etc/debian_version" \
        "/etc/issue" \
        "/etc/turbolinux-release" \
        "/etc/SuSE-release" \
        "/etc/mandriva-release" \
        "/etc/vine-release" \
        "/etc/issue" \
    )
    for item in ${DISTRI[@]}; do
        if [ -f $item ]; then cat $item && break; fi
    done
    echo ""
    printf "\033[31m%s\033[m\n" '* Disk info'
    # Disk space
    df -hT
}
