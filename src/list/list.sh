#!/bin/bash

# This header provides the choice based listing utility.
# It checks a certain directory for specified criterias, and
# lists them. 

# If no files are found, this returns a error flag, and handles
# the error. This terminates the program, as it is a lethal
# error.

# Define source code variable: __LIST_SH
if [[ "$__LIST_SH" -ne "1"]]; then
__LIST_SH=1
fi

# Include include
. $(dirname "$0")/src/include.sh

# Dependencies

if [[ $(echo -en $__COLORIZE_OUTPUT_SH) -eq "" ]]; then
include 'src/colorize_output.sh'
fi

if [[ $(echo -en $__COLORIZE_OUTPUT_SH) -eq "" ]]; then
include 'src/colorize_output.sh'
fi



