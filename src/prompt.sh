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
        Usage: colorize_output [-options ...] [texts] \n
        \n
        Colorize the output using various options. Call this function with the \n
        background and foreground color specified.
    ")

    echo -e $helpmsg
}