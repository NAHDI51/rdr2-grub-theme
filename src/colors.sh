#!/bin/bash

# This file handles the colorization of the console (stdin, stdout)


# Check if this file has previously been defined
# If not, define it, so that other files can include it.

if [$(echo -e $__COLOR_SH) -eq ""]; then
    __COLOR_SH="1"
fi

#beginning and ending of a color prompt
BEG="\e["
END="\e[0m"

# D=DARK
# L=LIGHT

BG_MODE=0
FG_MODE=1

# (Background codes, Foreground codes)
BLACK=("40" "30")
RED=("41" "31")
GREEN=("42" "32")
BROWN=("43" "43")
BLUE=("44" "34")
PURPLE=("45" "35")
CYAN=("46" "36")
LGRAY=("47" "37")

# formats

NORMAL="0"
UNDERLINED="4"
BLINKING="5"
#Bold isn't present here due to having different color contexts.

# There, however, are some differences of codes, when we use
# bold fonts. Thus, we need to define them distinctly.

# Bold (background codes, foreground codes)

B_DGRAY=("1;40" "1;30")
B_LRED=("1;41" "1;31")
B_LGREEN=("1;42" "1;32")
B_YELLOW=("1;43" "1;33")
B_LBLUE=("1;44" "1;34")
B_LPURPLE=("1;45" "1;35")
B_LCYAN=("1;46" "1;36")
B_WHITE=("1;47" "1;37")

