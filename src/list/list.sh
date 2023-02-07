#!/bin/bash

# This header provides the choice based listing utility.
# It checks a certain directory for specified criterias, and
# lists them. 

# If no files are found, this returns an error flag, and handles
# the error. This terminates the program, as it is a lethal
# error.

# Define source code variable: __LIST_SH
if [[ "$__LIST_SH" -ne "1" ]]; then
__LIST_SH=1
fi

# Include include
. $(dirname "$0")/src/include.sh

# Dependencies

if [[ $(echo -en $__COLORIZE_OUTPUT_SH) -eq "" ]]; then
include 'src/colorize_output.sh'
fi

if [[ $(echo -en $__PROMPT_SH) -eq "" ]]; then
include 'src/prompt.sh'
fi 


# Takes an input of a directory from the user, and
# lists the content of the directory according to the 

list_if() {
    
local helpmsg=('
Usage: list_if DIRECTORY CONDITION  
        
The list if function lists the contents of a directory according 
to the CONDITION specified. This is intended to be a simple wrap up 
to the conventional ls file. Thus, there are no default options,
meaning that you must always specify the DIRECTORY and CONDIDTION.
Furthermore, only the files of the first depth is considered. 
        
the CONDITION should be a function being called. Then, then each of 
the $ENTRY will be called as the $1 argument of CONDITION. 

Beware that the commands will be executed just as it is written. 
This is why, it is recommended flushing or adjusting the stdin, stdout
and stderr accordingly. For example, if your command is "ls -la .", it
will print all the output to stdout. To elude it, do "ls -la 2>&1 > 
/dev/null".
')

    # Any log from this function will start with this. 
    local LOG_HEADER=$(prompt -s "src/list.sh/list_if: ")
    
    # help message display
    case "$1" in 
        "-h" | "--help" | "--Help" )
            prompt -i "$helpmsg"
            return 0
            ;;
    esac

    local DIRECTORY="${1}"
    local CONDITION="${2}"

    # DIRECTORY is empty. 
    echo -e "$DIRECTORY"
    if [ "$DIRECTORY" == "" ]; then
        echo -en "$LOG_HEADER"
        prompt -e "FATAL ERROR: "
        echo -e "Directory not specified. Returning the function with exit status 1."
        # return 1
    fi

    # DIRECTORY is wrongly specified.. 
    if [ ! -d "$DIRECTORY" ]; then 
        echo -en "$LOG_HEADER"
        prompt -e "FATAL ERROR: "
        echo -e "Specified \"$DIRECTORY\" is not a directory. Returning the function with exit status 1."
        # return 1
    fi

    # CONDITION is empty. 
    if [ "$CONDITION" == "" ]; then 
        echo -en "$LOG_HEADER"
        prompt -e "FATAL ERROR: "
        echo -e "Condition not specified. Returning the function with exit status 1."
        return 1
    fi 

    # fetch all the entries
    # ISSUE: entries are not splitted according to newline
    local ENTRIES=$(ls -a "$DIRECTORY" 2>&1)
    readarray -t DIRS <<<"$ENTRIES"

    local TOTAL=1
    for PATH in ${DIRS[@]}
    do 

        if [ "$PATH" == "." ] || [ "$PATH" == ".." ]; then 
            continue
        fi

        # Run the condition. The user is responsible for handling
        # the buffer output. 

        ENTRY="$DIRECTORY/$PATH"
        "$CONDITION"

        # Do if the previous condition is right. 

        if [ $? == "0" ]; then
            colorize_output -F --blue -b "[$TOTAL] "
            colorize_output -F --yellow -u "$ENTRY\n"
            let "TOTAL++"
        fi
    done 
}


