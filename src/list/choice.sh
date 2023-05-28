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

# CHOICE_SH
# This program provides utilities for some choice-based selections, such as 
# choice from range, choice on yes/no, custom choice options created. This
# will be useful, if paired up with an OL list array.

# Include include 
. $(dirname "$0")/src/include.sh

# Define source based variable
if [[ "$__CHOICE_SH" -ne "1" ]]; then 
    __CHOICE_SH=1
fi 

# Dependencies

if [[ $__COLORIZE_OUTPUT_SH -eq "" ]]; then
include 'src/colors/colorize_output.sh'
fi

if [[ $__PROMPT_SH -eq "" ]]; then
include 'src/colors/prompt.sh'
fi 

if [[ "$__ALIASES_SH" -eq "" ]]; then 
    include 'src/aliases.sh'
fi 

# Choice from a range: [A-Z], [a-z], or [1-N]...
# Two arguments, specifying the first and the last.

ask() {
}

choiceRange() {
    local helpmsg=('
SYNTAX: choiceRange [START] [END]

The choiceRange function takes two arguments, START and END, 
and creates a choice based system. 

START and END format
------------------------------------------------------------

The $START and $END variables can hold three types: A, a, and 1.
Furthermore, both $START and $END has to be of the same type. 
Any exception to these rules will result in a warning, and the 
function will return 127. 

Example:

1. choiceRange a j 
This will query between the choices: [a-j].

2. choiceRange 1 29
This will query between the choices: [1-29].

@return value: the choice chosen
')   
    eval "$PRINT_HELPMSG"

}

choiceYN() {
    local helpmsg=('
SYNTAX: choiceYN 

The choiceYN function creates a choice based system dependant
on Y or N. Thus, no user argument is to be provided. 

@return value: the choice chosen
    ')

    eval "$PRINT_HELPMSG"
}

choiceCustom() {
    echo "Hello world"
}
