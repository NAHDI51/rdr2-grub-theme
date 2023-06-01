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

# SELF-EXPLANATORY file name and purpose

#!/bin/bash

# Check if this file has previously been defined
# If not, define it, so that other files can include it.


# Details of NEW DESIGN has been discussed in the include_once helpmsg function.
declare -A INCLUDED_HEADER


# parameters
# $0 = name of the file, from which the function is called
# $1 = name of the inclusion file, from the function being called

include() {
    local SOURCE=$0
    local FILE=$1

    # Store the error message, if there is any
    . $(dirname "$SOURCE")/$FILE

    # If any error occurs
    # Note that the inclusion error can be neglected depending on how important
    # it is. In my context, all the dependencies are essential, and, therefore,
    # cannot be neglected. However, if depenencies are optional, you can
    # take another argument identifying it, and implement another option
    # depending on it.

    # In that case, we can uncommon out this extra variable, and implement
    # for this variable
    # IMPORTANCE=$2

    if [ $? == 1 ]; then
        echo -e "\e[1;31mFATAL ERROR:\e[0m Could not resolve dependencies."
        echo -e "Called from \e[1;32m$SOURCE\e[0m"
        echo -e "To include \e[1;32m$FILE\e[0m"
        echo -e "\e[1;31mExitting\e[0m with status \e[1;31m1\e[0m"
        exit 1
    fi

    # Track inclusion 
    INCLUDED_HEADER["$FILE"]=1

    return $?
}



include_once() {
    local helpmsg=('
include_once [FILES...]

This function includes one or more bash source codes that follow the 
designs discussed below. For each of the files, this function will
check whether the file exists, and whether it has been included or
not. If not included, the function will include the source code. 

type include_once --help for displaying this message. 

NEW DESIGN
#################################################################

There are many wrongs with the C-style inclusion. Firstly, the 
inclusion takes a significant amount of length and readability. 
Secondly, it introduces unnecessary amount of if and subsequent
variables, due to which, it takes repeating the same structure.

This solution involves using an associative array for the fullname
of the file. The <string,bool> array will store true/false for 
whether the file has been included or not.

declare -A INCLUDED_HEADER
if (( -v INCLUDE_HEADER['code.sh'] ))       # indicates that the file has been included

Now the logic goes as follows:
1. A file can be included IFF the file exists. 
2. A file is included once IFF the INCLUDED_HEADER is 1.
')
    # display helpmsg if prompted. 
    case "$1" in 
        "-h" | "--help" | "--Help" )
            echo "$helpmsg"
            return 0
        ;;
    esac

    # Iterate and include the files
    for FILE in "$@"; do 
        if [[ ! -v INCLUDED_HEADER["$FILE"] ]]; then 
            include "$FILE"
        fi
    done 

}