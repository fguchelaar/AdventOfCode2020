#!/bin/bash

find -s . -name "*day*" -depth 1 -type d \
    -exec echo Building {} \; \
    -exec sh -c 'pushd . > /dev/null; cd $1; swift build -c release; popd > /dev/null' sh {} \;
