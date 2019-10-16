#!/bin/bash

set -x

msg2slack()
{
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$1\"}" "$SLACK_URL"
}

mkdir -p "$(helm home)/plugins"
helm plugin install https://github.com/instrumenta/helm-kubeval

name=$(git log -1 --pretty=format:'%an')
files=$(git diff HEAD^ --name-only)

for file in $files; do

    case "$file" in
    charts\/*) 
        chart_name="$(cut -d'/' -f2 <<<"$file")"
        chart=charts/$chart_name
        if helm lint "$chart" && helm kubeval --ignore-missing-schemas "$chart" ; then
            echo "${file} is valid"
        else
            msg2slack "Hey ${name}, ${file} is NOT valid"
        fi
        ;;
    *.y*ml*) 
        if [ -f "$file" ] || kubeval --ignore-missing-schemas "$file" ; then
            echo "${file} is valid"
        else
            msg2slack "Hey ${name}, ${file} is NOT valid"
        fi
        ;;
    *) echo "${file} not a yaml file" ;;
    esac

done
