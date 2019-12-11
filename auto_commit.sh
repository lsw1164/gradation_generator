#!/bin/sh

#title          :auto_commit.sh
#description    :This script will commit a dummy
#author         :swlee
#date           :2019-12-11
#version        :1.0.1
#==============================================================================

# Absolute path to this script, e.g. /home/user/bin/foo.sh
# Absolute path this script is in, thus /home/user/bin

DIR_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
DUMMY_FILE="${DIR_PATH}/dummy"

echo $DIR_PATH
echo $DUMMY_FILE

function update_current_date() {
    OLD_LANG=$LANG
    LANG="POSIX"
    CURRENT_DATE=$(echo $(date))
    LANG=$OLD_LANG 
    echo "CURRENT_DATE : ${CURRENT_DATE}"
}

function make_dummy_change() {
    if [ -f ${DUMMY_FILE} ]; then
        rm ${DUMMY_FILE}
    else 
        touch ${DUMMY_FILE}
    fi
}

function commit_with_current_date() {
    git add ${DUMMY_FILE}
    git commit -m "gradation" --date "${CURRENT_DATE}"
}

make_dummy_change
update_current_date
commit_with_current_date
