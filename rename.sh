#!/bin/bash

QFLAG=0
VFLAG=0
command=""
args=""

usage() {
    echo "Usage: $0 [-qv] <command> <args>..."
    exit
}

while test "$#" -ge 1; do
    case $1 in 
        -q) 
            QFLAG=1
            shift
            continue;;
        -v) 
            VFLAG=1
            shift
            continue;;
        -h)
            usage;;
        -*)
            echo "Unkown option $1"
            usage;;
        *)
            if test -z "$command"; then
                command=$1
            else
                args="$args \"$1\""
            fi
            shift
            continue;;
    esac
done

eval "set to_shift $args"

while test "$#" -ge 2; do
    shift

    if test ! -e "$1"; then 
        echo "$1 doesn't exist"
        continue
    fi

    A=$(eval "echo $1 | $command 2>/dev/null")
    if test $? -ne 0; then
        echo "Couldn't execute command    echo \"$1\" | $command   "
        continue
    fi


    if test -e "$A"; then
        echo
        echo "\"$1\" -> \"$A\""
        echo "\"$A\" already exists. Do you want to overwrite it ?"
        read -p "Confirm (y/N)? : " CONFIRM
        if test "$CONFIRM" != "y"; then
            continue
        fi
    elif test $QFLAG -eq 1; then
        echo
        echo "\"$1 -> $A\""
        read -p "Confirm (y/N)? : " CONFIRM
        if test "$CONFIRM" != "y"; then
            continue
        fi
    fi
    
    mv "$1" "$A"
    if test $VFLAG -eq 1; then
        echo "Renamed \"$1\" to \"$A\""
    fi
done