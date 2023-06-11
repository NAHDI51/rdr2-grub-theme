#!/bin/bash

for ENTRY in wallpapers/*; do 
    NAME=$(echo $ENTRY | awk -F'/' '{ print $NF }')
    mkdir create/$NAME 
    cp -r ../arthur-morgan/* create/$NAME
    cp -a $ENTRY/background.png create/$NAME/background.png
done 