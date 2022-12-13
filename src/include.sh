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