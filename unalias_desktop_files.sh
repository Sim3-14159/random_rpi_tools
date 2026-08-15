#!/bin/bash

cd ~/Desktop || exit 1

file_key_value() {
    local filename="$1"
    local keyname="$2"
    local line key value

    while IFS= read -r line; do
        key="${line%%=*}"
        value="${line#*=}"

        if [[ "$key" == "$keyname" ]]; then
            printf '%s\n' "$value"
            return
        fi
    done < "$filename"
}

for filename in *.desktop; do
    [[ -e "$filename" ]] || continue

    if [[ "$(file_key_value "$filename" "Type")" == "Link" ]]; then
        link_to_name="$(file_key_value "$filename" "URL")"
        cat "$link_to_name" > "$filename"
    fi
done
