#!/bin/bash

# This file handles output formatting and colorization of the console 
# output. This will take standard color codes of @background and
# @foreground, and output accordingly. Prompt 
# 
# 
# 

# dependency: include.sh
. $(dirname "$0")/src/include.sh

# Dependencies

if [[ $(echo -e $__COLORS_SH) -eq "" ]]; then
include 'src/colors.sh'
fi



# colorize_console: see $helpmsg for more options

colorize_output() {
    local helpmsg=("
        Usage: colorize_output [-options] ... [text] \n
        \n
        Colorize the output using various options. Call this function with the  \n
        background and foreground color operations specified. \n
        \n
        OPERATIONS \n
        -B | --background [FORMAT] [COLOR] \t Format the background text \n
        -F | --foreground [FORMAT] [COLOR] \t Format the foreground text \n
        -h | --help \t \t \t \t               Print this text
        \n
        FORMATS\n
        -r | --regular \n 
        -b | --bold \n
        -u | --underlined \t  Underlines the text \n
        -l | --blinking \t    Text blinks \n
        \n
        \n
        COLORS\n
        There are some different options available for bold formatting. Thus, \n 
        we cannot specify different exclusive colors to the vice versa. \n
        \n
        COLOR OPTION FLAGS FOR REGULAR/UNDERLINE/BLINK \n
        --black \n
        --red \n
        --green \n 
        --brown \n 
        --blue \n 
        --purple \n 
        --cyan \n 
        --light-gray \n
        \n
        COLOR OPTION FLAGS FOR BOLD \n
        --dark-gray \n
        --light-red \n
        --light-green \n 
        --yellow \n 
        --light-blue \n 
        --light-purple \n 
        --light-cyan \n
        --white \n
        \n
        \n
        DEFAULTS
        FORMAT     = Regular \n
        COLOR      = White \n
        Foreground = White regular text \n
        Background = No background \n
    ")

    #Stores the arguments called
    ARGS=()
    for Arg in $@
    do
        #append ARGS
        ARGS[${#ARGS[@]}]=$Arg
    done
}

# A generalized wrapper for colorize_output. Outputs messages
# according to their indication (e.g info, error, warning). See
# helpmsg for more details

prompt() {
    local helpmsg=("
        Usage: \n
        \n
        INFO \n
        1. Error prompt prints the prompt in BOLD RED. \n
        2. Info prompt prints the prompt in LIGHT GRAY. \n
        3. Warning prompt prints the prompt in yellow. \n 
        4. Success prompt prints the prompt in GREEN. \n
        5. Default prompt prints the prompt in WHITE. \n
        \n
    ")
    case $1 in 
        "-e" | "--error")
            colorize_output -F -r --red $2 ;;
        "-i" | "--info")
            colorize_output -F -r --light-gray $2 ;;
        "-w" | "--warning")
            colorize_output -F -b --yellow $2 ;;
        "-s" | "--success")
            colorize_output -F -b --light-green $2 ;;
        
        colorize_output -F $1
    esac
}