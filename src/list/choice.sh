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

if [[ $(echo -en $__COLORIZE_OUTPUT_SH) -eq "" ]]; then
include 'src/colors/colorize_output.sh'
fi

if [[ $(echo -en $__PROMPT_SH) -eq "" ]]; then
include 'src/colors/prompt.sh'
fi 

if [[ $(echo -en $__ITERATION_SH) -eq "" ]]; then 
include 'src/list/iteration.sh'
fi 

if [[ $(echo -en $__LIST_SH) -eq "" ]]; then 
include 'src/list/list.sh
fi 

choiceRange() {
    
}

choiceYN() {

}

choiceCustom() {

}
