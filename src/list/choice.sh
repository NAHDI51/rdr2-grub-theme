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
eval $START_INCLUDE_BASED_SYSTEM 2> /dev/null
include_once 'src/colors/colorize_output.sh' 'src/colors/prompt.sh' 'src/aliases.sh'


# Asks for the choice
askChoices() { 

    local QUESTION="$1"
    local MAIN_PROMPT="Please enter your choice"
    local HELP_PROMPT="(Press ~ to view the list of choices)"
    local ERR_PROMPT="[Invalid Choice]"

    local LAST_ERROR=0           # If the last prompt is ERROR or not
    local CHOICE_NOT_CHOSEN=1    # Turns false if the choice has been chosen

    local FINAL_CHOICE=""        # Return value, which will be stored once the prompting is over
    local CHOICE=''              # Choice 

    while (( $CHOICE_NOT_CHOSEN == 1 )); do 
        colorize_output -i -F --yellow "QUESTION: $QUESTION?\n"

        if (( $LAST_ERROR == 1)); then 
            colorize_output -F --red "$ERR_PROMPT "
        fi 
        
        # Prmopting
        colorize_output -F --blue   "$MAIN_PROMPT "
        colorize_output -F --yellow "$HELP_PROMPT"
        read -p ": " CHOICE
        # End prompting

        # choices can have 3 categories.
        # ~: displays help message
        # valid choice: if the choice exists
        # invalid choice: continue the loop.

        if [[ "$CHOICE" == '~' ]]; then 
            colorize_output -F --green "Choices:"
            echo -en "\n"

            for CHOICE in "${!CHOICES[@]}"; do 
                prompt -i "$CHOICE\t"
            done 
            echo -en "\n"

            LAST_ERROR=0
            CHOICE_NOT_CHOSEN=1

        # If the choice exists
        elif [[ -v CHOICES["$CHOICE"] ]]; then 
            FINAL_CHOICE="$CHOICE"

            LAST_ERROR=0
            CHOICE_NOT_CHOSEN=0

        else 
            LAST_ERROR=1
            CHOICE_NOT_CHOSEN=1
        fi
        
    done 
    
    RETURN_VALUE="$FINAL_CHOICE"
}

choiceCustom() {
    local helpmsg=('
SYNTAX: choiceCustom [CHOICES...]

The choiceCustom function takes an array of choices, and thinks
of them as custom choices. 

NOTE: use a different file descriptor when trying to assign the
returned value directly. 

Example:

choiceCustom a b c d e
This call consideres 5 individual choices: a, b, c, d, and e.

choiceCustom 1 a c 2 b f 6
This call consideres 7 individual choices: a, b, c, f, 1, 2, and 6.

@return value: the choice chosen
')
    eval $PRINT_HELPMSG

    local LOG_HEADER="src/list/choice.sh/choiceCustom()"
    check_err_arg_num $# 1
    
    if (( $? == 1 )); then 
        colorize_output -F --red "$LOG_HEADER: ERROR: Incorrect number of arguments. Returning with exit status 127.\n" 
        return 127
    fi 
    
    local QUESTION="$1"
    shift 1
    local ARGS=("$@")
    local n=$#
    
    # Store the choices in the associative array, and call ask 
    declare -A CHOICES 
    for (( i = 0; i < $n; i++ )); do 
        local idx=$i 

        # If the element already exists 
        if [[ -v CHOICES["${ARGS[i]}"] ]]; then 
            colorize_output -F --red "$LOG_HEADER: Warning: '${ARGS[i]}' has multiple instances.\n"
            i=$idx   # Avoid global variable collilsion
            continue 
        fi 

        CHOICES["${ARGS[i]}"]=1
    done 

    # unset global variables that could cause potential conflict
    unset i

    #Invoke the choice based system
    #No need to handle return value: the return value from the previous function is 
    #the return value of this function.
    askChoices "$QUESTION" CHOICES
    unset CHOICES
}

# Wrappers of choiceCustom choiceRange and choiceYN

# Choice from a range: [A-Z], [a-z], or [1-N]...
# Two arguments, specifying the first and the last.

choiceRange() {
    local helpmsg='
SYNTAX: choiceRange [QUESTION] [START] [END]

The choiceRange function takes three arguments, START and END, 
and creates a choice-based system. 

START and END format
------------------------------------------------------------

The $START and $END variables can hold three types: A, a, and 1.
Furthermore, both $START and $END have to be of the same type. 
Any exception to these rules will result in a warning, and the 
function will return 127. 

NOTE: use a different file descriptor when trying to assign the
returned value directly. 

Example:

1. choiceRange a j 
This will query between the choices: [a-j].

2. choiceRange 1 29
This will query between the choices: [1-29].

@return value: the choice chosen
'
    eval $PRINT_HELPMSG
    local LOG_HEADER="src/list/choice.sh/choiceRange()"
    
    check_err_arg_num $# 3 3
    if (( $? == 1 )); then
        colorize_output -F --red "$LOG_HEADER: ERROR: Incorrect number of arguments. Returning with exit status 127.\n"
        return 127
    fi

    local QUESTION="$1"
    local START="$2"
    local END="$3"

    # Error handling

    # Same type (The alphabets will also have to be of the same length of 1)
    local TYPE=""
        if [[ "$START" =~ [A-Z] && "$END" =~ [A-Z] && ${#START} -eq 1 && ${#END} -eq 1 ]]; then
        TYPE="uppercase"
    elif [[ "$START" =~ [a-z] && "$END" =~ [a-z] && ${#START} -eq 1 && ${#END} -eq 1 ]]; then
        TYPE="lowercase"
    elif [[ "$START" =~ ^-?[1-9][0-9]*$ && "$END" =~ ^-?[1-9][0-9]*$ ]]; then
        TYPE="numeric"
    else
        colorize_output -F --red "$LOG_HEADER: ERROR: START and END variables are not of the same type. \n"
        return 127
    fi

    # START <=END
    if [[ "$START" -gt "$END" ]]; then
        colorize_output -F --red "$LOG_HEADER: ERROR: START value cannot be greater than END value. \n"
        return 127
    fi

    local CHOICES=''
    case "$TYPE" in
        "uppercase" | "lowercase")
            CHOICES=($(eval echo {${START}..${END}})) ;;
        "numeric")
            CHOICES=($(seq "$START" "$END")) ;;
        *)
            colorize_output -F --red "$LOG_HEADER: ERROR: Unknown type \n"
            return 127 ;;
    esac

    # echo "${CHOICES[@]}"

    #No need to handle return value: the return value from the previous function is 
    #the return value of this function.
    choiceCustom "$QUESTION" "${CHOICES[@]}"
}

# SElf explanatory
choiceYN() {
    local helpmsg=('
SYNTAX: choiceYN [QUESTION]

The choiceYN function creates a choice based system dependant
on Y or N. Thus, no user argument is to be provided. 

NOTE: use a different file descriptor when trying to assign the
returned value directly. 

@return value: the choice chosen
')  

    eval "$PRINT_HELPMSG"

    check_err_arg_num $# 1 1
    if (( $? == 1 )); then
        colorize_output -F --red "$LOG_HEADER: ERROR: Incorrect number of arguments. Returning with exit status 127.\n"
        return 127
    fi
    
    local QUESTION="$1"

    #No need to handle return value: the return value from the previous function is 
    #the return value of this function.
    choiceCustom "$QUESTION" y n
}