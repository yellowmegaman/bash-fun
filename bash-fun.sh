#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'You should provide arguments, provide url'
    exit 1
elif [ ! $(command -v curl) ] ; then
    echo "curl is not present in the system"
    exit 1
fi

addr="$1"
IFS=$'\n'

for service in $(curl -s "$addr" | sed 's/<br \/>/\n/g' | grep -i 'nok\|DOWN\|degraded'); do
	name=$(echo "$service" | cut -d ':' -f1)
	status=$(echo "$service" | cut -d ':' -f2 | tr -d ' ')
	echo "The service $name is $status"
done
