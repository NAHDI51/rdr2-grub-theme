#!/bin/bash

# Include include
. $(dirname "$0")/src/include.sh

include_once 'src/colors/colorize_output.sh' 'src/colors/colors.sh' 'src/colors/prompt.sh'
include_once 'src/list/list.sh' 'src/list/iteration.sh' 'src/list/choice.sh'
include_once 'src/aliases.sh' 'src/thumbnail.sh' 'src/run_as_root.sh'

# echo "Reache dhere"


# NOTE: for the work of this application, we can list an element eligible IFF:
# 1. The entry is a directory. 
# 2. The entry directory has a file called "theme.txt". This will work as our
#    main theme.
compfunc='
compfunc() {
    # echo "Reached here"
    # echo $ENTRY
    if [ -d "$ENTRY" ] && [ -n "$(find "$ENTRY" -maxdepth 1 -type f -name "theme.txt" -print -quit)" ]; then
        return 0
    else
        # echo "Readhed here"
        return 1
    fi
}
'
# export COMMUNISM="comrade"
# echo $COMMUNISM

# run_as_root
# echo "$compfunc"


# list_if --help
list_if create "$compfunc"
# echo "${#RETURN_VALUE[@]} ${RETURN_VALUE[@]}"
# iterate 'a' 1 2 2 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  1 1 1 1 1 1 1 1 1 1 1  1 1 1 1 1
iterate 'a' ${RETURN_VALUE[@]}
choiceRange "Choose your option" ${RETURN_VALUE[@]}

# print_thumbnail

# choiceRange --help

# choiceYN

# choiceRange 1 10
# prompt -s "Your choice is: $RETURN_VALUE\n"

# choiceCustom "Do you bing chill" Y N "fuck you"
# echo "Your choice is: $RETURN_VALUE"