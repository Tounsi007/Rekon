#!/bin/bash

mkdir scripts
mkdir scriptsresponse

CUR_PATH=$(pwd)

for x in $(ls "$CUR_PATH/responsebody"| grep 'https$')
do
        END_POINTS=$(cat "$CUR_PATH/responsebody/$x" | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f 2)
        for end_point in $END_POINTS
        do
                len=$(echo $end_point | grep "http" | wc -c)
                mkdir "scriptsresponse/$x/"
                URL=$end_point
                if [ $len == 0 ]
                then
                        y=$(echo $x | sed 's/.\{6\}$//')
                        URL="https://$y$end_point"
                fi
                file=$(basename $end_point)
                curl -k $URL -L > "scriptsresponse/$x/$file"
                echo $URL >> "scripts/$x"
        done
done

for x in $(ls "$CUR_PATH/responsebody"| grep -v 'https$')
do
        END_POINTS=$(cat "$CUR_PATH/responsebody/$x" | grep -Eoi "src=\"[^>]+></script>" | cut -d '"' -f 2)
        for end_point in $END_POINTS
        do
                len=$(echo $end_point | grep "http" | wc -c)
                mkdir "scriptsresponse/$x/"
                URL=$end_point
                if [ $len == 0 ]
                then
                        y=$(echo $x | sed 's/.\{5\}$//')
                        URL="https://$y$end_point"
                fi
                file=$(basename $end_point)
                curl -k $URL -L > "scriptsresponse/$x/$file"
                echo $URL >> "scripts/$x"
        done
done
