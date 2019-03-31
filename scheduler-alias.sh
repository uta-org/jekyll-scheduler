#!/bin/bash

IFS="="

schedule_date=""
schedule_post=""

stamp_now=$(date --date=$(date --iso-8601) +%s 2>/dev/null)
stamp_file=""

while read -r name value
do
    if [[ $name == "schedule_date" ]]; then
        schedule_date="$value"
        stamp_file=$(date --date=$value +%s 2>/dev/null)
    elif [[ $name == "schedule_post" ]]; then
        schedule_post="$value"

        # Then do the magic
        delta=$(($stamp_now-$stamp_file))

        if [[ delta -ge 0 ]]; then
        	echo "Publishing post: $schedule_post"
            mv "$PWD/scheduled-posts/$schedule_post" "$PWD/_posts/$schedule_post"
        fi
    fi
done < "$PWD/script/sch.ini"

git add .
git commit -m "Publishing posts"
git push -u origin master