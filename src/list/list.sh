# Copyright (C) 2023 NAHDI51
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

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
include 'src/colors/colorize_output.sh'
fi

if [[ $(echo -en $__PROMPT_SH) -eq "" ]]; then
include 'src/colors/prompt.sh'
fi 


# Takes an input of a directory from the user, and
# lists the content of the directory according to the 

list_if() {
    
local helpmsg=('
Usage: list_if DIRECTORY CONDITION  
        
The list if function @returns the contents of a directory according 
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

NOTES ON WRITING THE CONDITION
-------------------------------------------------------------------------
Writing the condition is entirely up to the user. The user is responsible 
for desiging however the condition will be applied. From this source code,
only he lines

eval "$CONDITION" 
compfunc

will be applied, so the program is only responsible for parsing the raw
string. 

There should be a function "compfunc" inside the string, which will be called
as the CONDITION in this file. For example:

compfunc="
compfunc() {
    if [ "$(find $ENTRY -name "theme.txt" | awk -F/ "{print \$NF}")" == "theme.txt" ]; then
        return 0
    else
        return 1
    fi
}
"
[Replace the double quotes above with single quotes]

which finds for the "theme.txt" file, and returns true, if it finds so. 
Now, we can call the function such as the following:

list_if create "$compfunc"

This will execute these line of codes using eval. 

eval "$CONDITION"  # gluing the function
compfunc           # The function call

which, necessarily, is the same as injecting a block of codes inside a
source code, and executing them. 

-----------------------------------------------------------------------

NOTES: 

1. you can use the directory you are currently traversing by calling
"$DIRECTORY/$PATH", or "$ENTRY"

2. On default, the list_if function echos the array. Thus, if you want
to use the returned value in another function or block, you can do the
following:

RETURNED_LIST = $(list_if DIRECTORY CONDITION)

$RETURNED_LIST will be an array with the resulting strings or directories.
')

    # Any log from this function will start with this. 
    local LOG_HEADER=$(prompt -s "src/list.sh/list_if: ")
    
    # help message display
    eval "$PRINT_HELPMSG"

    local DIRECTORY="${1}"
    local CONDITION="${2}"

    # DIRECTORY is empty. 
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

    # Initialize the list storage. All the right values are stored here.
    local ENTRIES=()

    for DIR in ${DIRS[@]}
    do 
        if [ "$DIR" == "." ] || [ "$DIR" == ".." ]; then 
            continue
        fi

        # Run the condition. The user is responsible for handling
        # the buffer output. Check helpmsg for more details as to
        # how to do so.

        ENTRY=("$DIRECTORY/$DIR")

        # echo -en "$ENTRY "
        # echo "$CONDITION"
        eval "$CONDITION"
        compfunc
        # echo "$?"

        # Do if the previous condition was rightly executed. 
        if [ $? == 0 ]; then
            ENTRIES+=("$ENTRY")
        fi
    done

    if [[ ${#ENTRIES[@]} == 0 ]]; then 
        colorize_output -F --yellow -B --red "$LOG_HEADER: Warning: No entires with the specified CONDITION found.\n"
    fi
    echo "${ENTRIES[@]}"
}


