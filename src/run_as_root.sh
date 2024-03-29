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

# This source code verifies whether the program is run as root, or not.
# If the program is run as root, this function will ask for permission,
# whether you will run it as root or not.

# Include C style dependency inclusion
eval $START_INCLUDE_BASED_SYSTEM 2> /dev/null
include_once 'src/colors/prompt.sh' 'src/list/choice.sh'

run_as_root()
{
    if [[ "$USER" != "root" ]]; then

        choiceYN "Do you want to run this program as a root"
        RESPONSE=$RETURN_VALUE

        case $RESPONSE in 
            "y") 
                prompt -i "Entering the program as root.\n"
                sudo "$0"
                exit 0
                ;;
            "n")
                prompt -s "Exitting the program.\n"
                exit 0
                ;;
            *)
                prompt -e "FATAL ERROR: Unknown answer. Exitting the program. \n"
                exit 1
                ;;
        esac

    fi 

}