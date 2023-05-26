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

# Iterate: iteraties through the ordered list specified
# Check helpmsg for all details. 

iterate() {
    helpmsg = ('
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

    # help message display
    case "$1" in 
        "-h" | "--help" | "--Help" )
            prompt -i "$helpmsg"
            return 0
            ;;
    esac

}