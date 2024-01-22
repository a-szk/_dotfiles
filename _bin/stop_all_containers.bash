#!/bin/bash
# use arg -q to be no output
#
# the same as the following: 
# docker stop $(docker ps -q) 1>/dev/null
#

is_out=true
arg_quiet="-q"
if [ $# -eq 1 ]; then
    if [ $1 = $arg_quiet ]; then
        is_out=false
    fi
fi

if "${is_out}" ; then
    show_containers.sh
fi

output=""

ID_List=`docker ps --format '{{ .Names }}' `
for ID in $ID_List
do
    docker stop $ID 1>/dev/null
    output="$output, $ID"
done


if "${is_out}" ; then
    echo ""
    echo ""
    echo ""
    if [ -n "$output" ];then
        echo "stop: `echo $output | cut - -b 3-`"
    else
        echo " no container found"
    fi
fi

