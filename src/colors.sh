#!/bin/bash

# This file handles the colorization of the console (stdin, stdout)


# Check if this file has previously been defined
# If not, define it, so that other files can include it.

if [${echo -e $__COLOR_SH} -eq ""]; then
    __COLOR_SH="1"
fi

#beginning and ending of a color prompt
BEG="\e["
END="\e[0m"

# D = DARK
# L = LIGHT

# Background codes
B_BLACK="40"
B_RED="41"
B_GREEN="42"
B_BROWN="43"
B_BLUE="44"
B_PURPLE="45"
B_CYAN="46"
B_LGRAY"47"

# Foreground codes
F_BLACK="30"
F_RED="31"
F_GREEN="32"
F_BROWN="33"
F_BLUE="34"
F_PURPLE="35"
F_CYAN="36"
F_LGRAY="37"

# formats
NORMAL="0"
UNDERLINED="4"
BLINKING="5"

# There, however, are some differences of codes, when we use
# bold fonts. Thus, we need to define them distinctly.

# Bold background codes

BB_DGRAY="1;40"
BB_LRED="1;41"
BB_LGREEN="1;42"
BB_YELLOW="1;43"
BB_LBLUE="1;44"
BB_LPURPLE="1;45"
BB_LCYAN="1;46"
BB_WHITE="1;47"

# Bold foreground codes

BF_DGRAY="1;30"
BF_LRED="1;31"
BF_LGREEN="1;32"
BF_YELLOW="1;33"
BF_LBLUE="1;34"
BF_LPURPLE="1;35"
BF_LCYAN="1;36"
BF_WHITE="1;37"


