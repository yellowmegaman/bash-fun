#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'You should provide arguments, provide url'
    exit 1
elif [ ! $(command -v curl) ] ; then
    echo "curl is not present in the system"
    exit 1
fi

addr="$1"
err=0

while read -r service
do
        name=$(echo "$service" | cut -d ':' -f1)
        status=$(echo "$service" | cut -d ':' -f2 | tr -d ' ')
        echo "The service $name is $status"
        err=$((err+1))
done < <(curl -s "$addr"|sed 's/<br \/>/\n/g'|grep -i 'nok\|DOWN\|degraded')

if [ "$err" != "0" ]; then exit 1; fi
