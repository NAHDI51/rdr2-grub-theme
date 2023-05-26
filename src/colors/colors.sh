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

# This file handles the colorization of the console (stdin, stdout)


# Check if this file has previously been defined
# If not, define it, so that other files can include it.

if [$(echo -e $__COLOR_SH) -eq ""]; then
    __COLOR_SH="1"
fi

#beginning and ending of a color prompt
BEGCOL="\e["
ENDCOL="\e[0m"

# D=DARK
# L=LIGHT

BG_MODE=0
FG_MODE=1

# (Background codes, Foreground codes)
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

NORMAL="0"
BOLD="1"
FAINT="2"
ITALICS="3"
UNDERLINED="4"
BLINKING="5"