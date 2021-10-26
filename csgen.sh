#!/bin/sh
pwd
find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' -o -name '*.aidl' \
    | grep -v 'out/target/*' | grep -v 'develop/*' > cscope.files
cscope -b -k
