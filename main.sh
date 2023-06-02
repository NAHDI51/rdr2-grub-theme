#!/bin/bash

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


# 1. Traverse the create folder, and list the files
# 2. Traverse the background file for the name of the folder specified,
#    and list the backgrounds
# 3. Copy a background image to the create directory
# 4. Ask whether to create the tar file or not. yes/no will not affect the 
#    control flow of the program.
# 5. check whether a theme like that already exists or not. 
# 6. If exists, ask whether to overwrite the theme or not. 
# 7. If yes, copy and grub-update, with updated specifications.
# 8. If no, grub-update with the default specifications.
# 9. Exit.


# Dependencies
. $(dirname "$0")/src/include.sh

include_once 'src/colors/colorize_output.sh' 'src/colors/colors.sh' 'src/colors/prompt.sh'
include_once 'src/list/list.sh' 'src/list/iteration.sh' 'src/list/choice.sh'
include_once 'src/aliases.sh' 'src/thumbnail.sh' 'src/run_as_root.sh'

run_as_root 
print_thumbnail



