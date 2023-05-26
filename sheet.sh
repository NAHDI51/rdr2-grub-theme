#!/bin/bash

# Include include
. $(dirname "$0")/src/include.sh

# Include external dependencies

if [[ "$__LIST_SH" -eq "" ]]; then
    include 'src/list/list.sh'
fi

if [[ "$__COLORIZE_OUTPUT_SH" -eq "" ]]; then 
    include 'src/colors/colorize_output.sh'
fi

if [[ "$__PROMPT_SH" -eq "" ]]; then 
    include 'src/prompt.sh'
fi

if [[ "$__THUMBNAIL_SH" -eq "" ]]; then 
    include 'src/thumbnail.sh'
fi 

compfunc='
compfunc() {
    if [ "$(find $ENTRY -name "theme.txt" | awk -F/ "{print \$NF}")" == "theme.txt" ]; then
        return 0
    else
        return 1
    fi
}
'

# echo "$compfunc"

# list_if --help
# list_if create "$compfunc"

print_thumbnail 