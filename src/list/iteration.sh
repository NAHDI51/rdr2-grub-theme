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


# ITERATION_SH
# This kind of works like the <ol> tag in html. You get to specify a
# <li> type, like 1,a, or A. This file is created with the intention
# to use it in a choice-based system. 

# Define source code variable: __ITERATION_SH
if [[ "$__ITERATION_SH" -ne "1" ]]; then
__ITERATION_SH=1
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

# Iterate: iteraties through the ordered list specified
# Check helpmsg for all details. 

iterate() {
    local helpmsg=('
iterate TYPE ARGUMENT(S)

iterate function creates an ordered list of the Arguments provided, 
and iterates through the list. Acceptable TYPE(S) are A, a, or 1. 
Unfortunately, no i has been implemented yet, at the time of 
writing this code. 

NOTE that lists with elements exceeding 26 cannot be iterated with
a or A. In that case, the program will return a warning, and will
proceed to continue with 1. 

By default, the buffer is colored with Blue list, and red elements. 
At the time of writing this code, any frontend UI has not been
written to change it via arguments. If you want to change it, 
please do so from the source code itself. 

Run iterate --help to view this message. 
')
    local LOG_HEADER="src/list/iteration.sh"

    # help message display
    case "$1" in 
        "-h" | "--help" | "--Help" )
            prompt -i "$helpmsg"
            return 0
            ;;
    esac

    # The function will have at least 1 mandatory argument (provided
    # that there can be 0 or more optional list arguments)

    if [[ $# < 1 ]]; then 
        colorize_output -F --yellow -B --red "$LOG_HEADER: Warning: insufficient arguments to call the function. Exitting the function with ERROR CODE: 127\n"
        return 127
    fi 

    local LIST_TYPE=$1
    shift 1
    local ARGS=("$@")  # Store arguments in an array

    if [[ $LIST_TYPE == 'a' || $LIST_TYPE == 'A' ]] && (( ${#ARGS[@]} > 26 )); then
        colorize_output -F --yellow -B --red "$LOG_HEADER: Warning: too many arguments for the type: $LIST_TYPE. Using TYPE 1 instead."
        LIST_TYPE='1'
    fi
    
    local n=${#ARGS[@]}
    local i=0

    # First and last bound of the list
    local char=''
    local first_char=''

    for ((i = 0; i < $n; i++)); do
        # POTENTIAL CONFLICT BETWEEN GLOBAL VARIABLES
        # colorize_output function's ITERATIVE variable $i is global, thus
        # it can meddle with this code's i iteration. This can potentially
        # cause an infinite loop.
        # 
        # The workaround is to preserve the value of $i in this function, in
        # a temporary variable called idx, and use it whenwever needed. This,
        # however, is just a temporary solution, and some fixes need to be done
        # with this control flow exception.

        local idx=$i

        case "$LIST_TYPE" in
            'a')
                # ASCII of 'a'+$i
                char=$(printf "\\$(printf '%03o' $((i+97)))")
                ;;
            'A')
                # ASCII of 'A'+$i
                char=$(printf "\\$(printf '%03o' $((i+65)))")
                ;;
            '1')
                # No need to do ASCII. Use decimal instead
                char=$((i+1))
                ;;
            *)
                colorize_output -F --red -B --black "$LOG_HEADER: FATAL ERROR: $LIST_TYPE is not a valid LIST TYPE. Exiting the function with code 127.\n" 
                i=$idx
                exit 127
                ;;
        esac

        if (( i == 0 )); then 
            first_char=$char
        fi

        # Why did I ever choose to torture myself with bash script T_T
        colorize_output -F --red -B --black "$char." && i=$idx
        colorize_output -F --blue "${ARGS[i]}" && i=$idx
        echo -en "\n"
    done

    unset i

    local RETURN_VALUE=("$first_char" "$char")
    echo "${RETURN_VALUE[@]}"  # Return the array elements
}