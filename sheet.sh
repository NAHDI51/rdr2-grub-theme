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


# NOTE: for the work of this application, we can list an element eligible IFF:
# 1. The entry is a directory. 
# 2. The entry directory has a file called "theme.txt". This will work as our
#    main theme.
compfunc='
compfunc() {
    echo "Reached here"
    echo $ENTRY
    if [ -d "$ENTRY" ] && [ -n "$(find "$ENTRY" -maxdepth 1 -type f -name "theme.txt" -print -quit)" ]; then
        return 0
    else
        echo "Readhed here"
        return 1
    fi
}
'

# echo "$compfunc"

# list_if --help
list_if themes "$compfunc"

# print_thumbnail