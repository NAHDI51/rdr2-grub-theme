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

# A generalized wrapper for colorize_output. Outputs messages
# according to their indication (e.g info, error, warning). See
# helpmsg for more details

# define header: _COLORIZE_OUTPUT_SH
if [[ $(echo -en $__PROMPT_SH) -eq "" ]]; then
__PROMPT_SH="1"
fi

# dependency: include.sh
. $(dirname "$0")/src/include.sh

# Dependencies

if [[ $(echo -en $__COLORIZE_OUTPUT_SH) -eq "" ]]; then
include 'src/colors/colorize_output.sh'
fi


prompt() {
    local helpmsg=("
        Usage: prompt [MODE] [STATEMENT]\n
        \n
        This is a generalized wrapper for colorize_output. Output specific \n
        indicative messages (e.g info, error, warning). \n
        \n
        This program assumes the first argument to be the mode, and the second \n
        argument to be the statement. \n
        \n
        MODES \n
        -h | --help  \t\t Displays this message. \n
        -e | --error \t\t Indicates that the following message is an ERROR prompt. \n
        -i | --info  \t\t Indicates that the following message is an INFO prompt. \n
        -w | --warning \t Indicates that the following message is a WARNING prompt. \n
        -s | --success \t Indicates that the following message is a SUCCESS prompt. \n    
        -c | --caution \t Indicates that the following message is a CATUIONARY prompt. \n
        \n
        DEFAULTS \n
        1. Error prompt prints the prompt in BOLD RED. \n
        2. Info prompt prints the prompt in LIGHT GRAY. \n
        3. Warning prompt prints the prompt in yellow. \n 
        4. Success prompt prints the prompt in GREEN. \n
        5. Default prompt prints the prompt in WHITE. \n
        6. Caution prompt blinks the background in RED, while prints the prompt \n
           in BLACK. \n
        \n
        For the time being, no argument-through changing of the defaults \n
        is implemented. Thus, if you want to change, do it through the color \n
        flags being called in below. \n
        \n
    ")
    case $1 in 
        "-h" | "--help")
            echo -e "$helpmsg" ;;
        "-e" | "--error")
            colorize_output -r -F --red "$2" ;;
        "-i" | "--info")
            colorize_output -r -F --light-gray "$2" ;;
        "-w" | "--warning")
            # echo -e "$1 $2"
            colorize_output -b -F --yellow "$2" ;;
        "-s" | "--success")
            colorize_output -b -F --light-green "$2" ;;
        "-c" | "--caution")
            colorize_output -l -B --light-red -F --black "$2" ;;
        *)
            echo -ne $1 ;;
    esac

    return 0
}