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

if [[ $(echo -e $__INCLUDE_SH) -eq '' ]]; then
    __INCLUDE_SH="1"
fi

# handles the inclusion of other source code files.
# Does the required error handling if error.

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

    return $?
}