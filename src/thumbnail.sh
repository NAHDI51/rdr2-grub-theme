# GPL HEADER

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

# This file defines the thumbnail files of the whole 
# project. Author Name, project name, and other meta
# datas are presented in this file.

# Include include
eval $START_INCLUDE_BASED_SYSTEM 2> /dev/null
include 'src/colors/colorize_output.sh'


# Generated via link: https://manytools.org/hacker-tools/ascii-banner/
# BANNER #1
# BANNER TEXT: NAHDI51
# BANNER FONT: Banner3
# HORIZONTAL SPACING: NARROW
# VERTICAL SPACING: FITTED
AUTHOR_BANNER=('
##    ##    ###    ##     ## ########  #### ########   ##   
###   ##   ## ##   ##     ## ##     ##  ##  ##       ####   
####  ##  ##   ##  ##     ## ##     ##  ##  ##         ##   
## ## ## ##     ## ######### ##     ##  ##  #######    ##   
##  #### ######### ##     ## ##     ##  ##        ##   ##   
##   ### ##     ## ##     ## ##     ##  ##  ##    ##   ##   
##    ## ##     ## ##     ## ########  ####  ######  ######                                                                                                                                                  
')

# Generated via link: https://manytools.org/hacker-tools/ascii-banner/
# BANNER #1
# BANNER TEXT: 
# RDR2 GRUB
# THEME
# BANNER FONT: DOS Rebel
# HORIZONTAL SPACING: NARROW
# VERTICAL SPACING: FITTED
PROJECT_BANNER=('
 ███████████   ██████████   ███████████    ████████             
░░███░░░░░███ ░░███░░░░███ ░░███░░░░░███  ███░░░░███            
 ░███    ░███  ░███   ░░███ ░███    ░███ ░░░    ░███            
 ░██████████   ░███    ░███ ░██████████     ███████             
 ░███░░░░░███  ░███    ░███ ░███░░░░░███   ███░░░░              
 ░███    ░███  ░███    ███  ░███    ░███  ███      █            
 █████   █████ ██████████   █████   █████░██████████            
░░░░░   ░░░░░ ░░░░░░░░░░   ░░░░░   ░░░░░ ░░░░░░░░░░             
   █████████  ███████████   █████  █████ ███████████            
  ███░░░░░███░░███░░░░░███ ░░███  ░░███ ░░███░░░░░███           
 ███     ░░░  ░███    ░███  ░███   ░███  ░███    ░███           
░███          ░██████████   ░███   ░███  ░██████████            
░███    █████ ░███░░░░░███  ░███   ░███  ░███░░░░░███           
░░███  ░░███  ░███    ░███  ░███   ░███  ░███    ░███           
 ░░█████████  █████   █████ ░░████████   ███████████            
  ░░░░░░░░░  ░░░░░   ░░░░░   ░░░░░░░░   ░░░░░░░░░░░             
 ███████████ █████   █████ ██████████ ██████   ██████ ██████████
░█░░░███░░░█░░███   ░░███ ░░███░░░░░█░░██████ ██████ ░░███░░░░░█
░   ░███  ░  ░███    ░███  ░███  █ ░  ░███░█████░███  ░███  █ ░ 
    ░███     ░███████████  ░██████    ░███░░███ ░███  ░██████   
    ░███     ░███░░░░░███  ░███░░█    ░███ ░░░  ░███  ░███░░█   
    ░███     ░███    ░███  ░███ ░   █ ░███      ░███  ░███ ░   █
    █████    █████   █████ ██████████ █████     █████ ██████████
   ░░░░░    ░░░░░   ░░░░░ ░░░░░░░░░░ ░░░░░     ░░░░░ ░░░░░░░░░░ 
   WRITTEN BY: NAHDI51
')

DONE_BANNER=('                                   
██████╗  ██████╗ ███╗   ██╗███████╗██╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝██║
██║  ██║██║   ██║██╔██╗ ██║█████╗  ██║
██║  ██║██║   ██║██║╚██╗██║██╔══╝  ╚═╝
██████╔╝╚██████╔╝██║ ╚████║███████╗██╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝
Github repository: https://github.com/NAHDI51/rdr2-grub-theme
Please leave a star if you like the project!
')                                  

print_thumbnail() {
    colorize_output -F --red "$PROJECT_BANNER"
}

print_footer() {
    colorize_output -F --green "$DONE_BANNER"
}