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

eval $START_INCLUDE_BASED_SYSTEM 2> /dev/null
include 'src/aliases.sh'

grub-update() {
    if has_command update-grub; then
        update-grub
    elif has_command grub-mkconfig; then
        grub-mkconfig -o /boot/grub/grub.cfg
    elif has_command grub2-mkconfig; then
        if has_command zypper; then
            grub2-mkconfig -o /boot/grub2/grub.cfg
        elif has_command dnf; then
        grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}