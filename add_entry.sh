#!/bin/bash

for ENTRY in wallpapers/*; do 
    NAME=$(echo $ENTRY | awk -F'/' '{ print $NF }')
    # mkdir -p build
    tar -czvf build/$NAME.tar.gz create/$NAME

    # mkdir create/$NAME 
    # cp -r ../arthur-morgan/* create/$NAME
    # cp -a $ENTRY/background.png create/$NAME/background.png
done 