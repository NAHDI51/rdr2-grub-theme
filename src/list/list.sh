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
to the conventional ls file. Thus, there are no default options. 
Furthermore, only the files of the first depth is considered. 
        
the CONDITION is called for every single entry of the lists in the
traversal. The default variable call for each of the entries is 
"$ENTRY".
')
    
    case "$1" in 
        "-h" | "--help" | "--Help" )
            prompt -i "$helpmsg"
            return 0
            ;;
    esac
}


