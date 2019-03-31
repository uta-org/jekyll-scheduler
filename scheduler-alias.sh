#!/bin/bash

IFS="="

schedule_date=""
schedule_post=""

while read -r name value
do
    if [[ $name == "schedule_date" ]]; then
        schedule_date="$value"
    elif [[ $name == "schedule_post" ]]; then
        schedule_post="$value"

        # Then do the magic
        if [[ $schedule_date == "$(date +%Y-%m-%d)" ]]; then
        	echo "Publishing post: $schedule_post"
            mv "$PWD/scheduled-posts/$schedule_post" "$PWD/$schedule_post"
        fi
    fi
done < "$PWD/script/sch.ini"