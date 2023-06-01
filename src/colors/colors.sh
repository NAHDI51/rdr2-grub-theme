#!/bin/bash

# This file handles the colorization of the console (stdin, stdout)


# Check if this file has previously been defined
# If not, define it, so that other files can include it.

#beginning and ending of a color prompt
BEGCOL="\e["
ENDCOL="\e[0m"

# D=DARK
# L=LIGHT

BG_MODE=1
FG_MODE=0

# (Foreground codes, Background codes)
BLACK=("30" "40")
RED=("31" "41")
GREEN=("32" "42")
YELLOW=("33" "43")
BLUE=("34" "44")
MAGNETA=("35" "45")
CYAN=("36" "46")
LGRAY=("37" "47")
GRAY=("90" "100")
LRED=("91" "101")
LGREEN=("92" "102")
LYELLOW=("93" "103")
LBLUE=("94" "104")
LMAGNETA=("95" "105")
LCYAN=("96" "106")
WHITE=("97" "107")


# formats

REGULAR="0"
BOLD="1"
FAINT="2"
ITALICS="3"
UNDERLINED="4"
BLINKING="5"

# Debugging purposes

FLAG="Reached here."