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
include_once 'src/update_grub.sh'

run_as_root 
print_thumbnail

# List the directories
colorize_output -F --cyan "\n\nLIST OF THEMES\n----------------\n"
list_if 'create' "$HAS_THEME_FILE"  # List subdirectories with theme.txt file in it.
DIRECTORIES="${RETURN_VALUE[@]}"

# Get choice and index
iterate '1' ${RETURN_VALUE[@]}      # Iterate the lists with type 1 (e.g 1, 2, 3...)
echo -en "\n\n" 
choiceRange 'Which theme do you want to set up' ${RETURN_VALUE[@]}   # RETURN VALUE reperesents first and last.
CHOSEN_DIR=$(get_index $((RETURN_VALUE-1)) ${DIRECTORIES[@]})
THEME_NAME=$(echo "$CHOSEN_DIR" | awk -F'/' '{print $NF}')

# Output the update
prompt -i "You have chosen the following theme: "
colorize_output -F --blue "$THEME_NAME\n"

# Backgrond
BACKGROUND_DIR="wallpapers/$THEME_NAME"
prompt -i "Searching for backgrounds in the directory: "
colorize_output -F --blue "$BACKGROUND_DIR\n"

# List the backgrounds 
list_if "$BACKGROUND_DIR" "$IS_BACKGROUND_IMAGE"
BACKGROUNDS="${RETURN_VALUE[@]}"

# Get choice and Index
colorize_output -F --cyan "\n\nLIST OF BACKGROUNDS\n------------------------\n"
iterate '1' ${RETURN_VALUE[@]}
echo -en "\n\n"

choiceRange 'Which background do you want to use' ${RETURN_VALUE[@]}  # RETURN VALUE represents first and last
CHOSEN_BACKGROUND=$(get_index $((RETURN_VALUE-1)) ${BACKGROUNDS[@]})

# Output the update
prompt -i "You have chosen the following background: "
colorize_output -F --blue "$CHOSEN_BACKGROUND\n\n"

# Create tarball or not
prompt -i "[INFO]: creating tarball will let you use grub-customizer to setup the theme.\n"
choiceYN "Do you want to create a tarball in the build directory"
CREATE_TARBALL=$RETURN_VALUE
echo -en "\n\n"

##########################################################
# Check for the existance of the theme
##########################################################

GRUB_THEME_DIR='/usr/share/grub/themes'
OVERWRITE='no'
if [[ -d  "$GRUB_THEME_DIR/$THEME_NAME" ]]; then 
    prompt -w "Warning: Theme $THEME_NAME already exists in the $GRUB_THEME_DIR directory.\n"
    choiceCustom "quit or overwrite" 'quit' 'overwrite'

    if [[ $RETURN_VALUE == 'quit' ]]; then 
        prompt -s "Changes will not be applied. Exitting the program with return value 0.\n"
        return 0
    fi

    OVERWRITE='yes'
    prompt -i "You have chosen to overwrite the theme: "
    colorize_output -F --blue "$GRUB_THEME_DIR/$THEME_NAME"
fi

echo -en "\n\n"

########################################################
# Create chosen configurations
#######################################################

CONFIGURATIONS="Chosen theme: $THEME_NAME"
CONFIGURATIONS[${#CONFIGURATIONS[@]}]="Chosen background: $CHOSEN_BACKGROUND"

if [[ $CREATE_TARBALL == 'y' ]]; then 
    CONFIGURATIONS[${#CONFIGURATIONS[@]}]="Tarball file will be created."
else 
    CONFIGURATIONS[${#CONFIGURATIONS[@]}]="Tarball file will not be created."
fi 

if [[ $OVERWRITE == 'yes' ]]; then 
    CONFIGURATIONS[${#CONFIGURATIONS[@]}]="Theme directory exists, and will be overwritten."
else 
    CONFIGURATIONS[${#CONFIGURATIONS[@]}]="Theme dir doesn't exist, and will be created."
fi
# List the configurations
colorize_output -F --cyan "CONFIGURATIONS\n--------------\n"
iterate '1' "${CONFIGURATIONS[@]}"
echo -en "\n\n"


###################################
#Confirmation
###################################

choiceYN "Are these settings okay"
CONFIRM_FINAL=${RETURN_VALUE}
echo -en "\n\n"

if [[ $CONFIRM_FINAL == 'n' ]]; then 
    prompt -s "Changes will not be applied. Exitting the program with return value 0.\n"
    return 0
fi 


###################################
# PROCEDURE
###################################

colorize_output -F --cyan --bold "Beginning the procedure.\n"

# Copy background to the dir file
cp $CHOSEN_BACKGROUND "create/$THEME_NAME/background.png"
prompt -i "Copied $CHOSEN_BACKGROUND to create/$THEME_NAME.\n"

# Create tar file
if [[ $CREATE_TARBALL == 'y' ]]; then 
    if [[ ! -d build ]]; then 
        mkdir build
    fi 
    tar -czf build/arthur-morgan.tar.gz create/arthur-morgan
    prompt -i "Created the tar file of the theme.\n"
fi

# Copy to the theme files

# Overwrite
if [[ $OVERWRITE == 'y' ]]; then 
    rm -rf $GRUB_THEME_DIR/$THEME_NAME 
    prompt -i "Deleted the previous theme entry.\n"
fi 

mkdir -p "$GRUB_THEME_DIR/$THEME_NAME"
cp -a create/"$THEME_NAME"/* "$GRUB_THEME_DIR/$THEME_NAME"
prompt -i "Installed $THEME_NAME.\n"

# Backup grub config
cp -a /etc/default/grub /etc/default/grub.bak
prompt -i "Backed the previous grub file up.\n"

#Setting theme
grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"$GRUB_THEME_DIR/$THEME_NAME/theme.txt\"" >> /etc/default/grub
prompt -i "Setted the grub theme.\n"

# Update grub
prompt -i "Updating the grub\n"
grub-update
print_footer














