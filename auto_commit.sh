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
COMMIT_CNT=0
DAY_AGO=0

echo $DIR_PATH
echo $DUMMY_FILE

#options
#d - How many days ago
#n - the number of commit count
while getopts "n:d:" opt; do
    case $opt in
        d)
            DAY_AGO=$(echo "${OPTARG}" | bc)
            ;;
        n)
            COMMIT_CNT=$(echo "${OPTARG}" | bc)
            ;;
        \?) 
            echo >&2 "ERR: Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            echo >&2 "ERR: Option -$OPTARG requires an argument."
            exit 1
            ;;
    esac
done

function validate_params() {
    re='^[0-9]+$'
    if ! [[ $COMMIT_CNT =~ $re ]] ; then
        echo "ERR: -n option requires on a number argument."
        exit 1
    fi
    if [[ $COMMIT_CNT -le 0 ]]; then
        echo "ERR: -n option requires on a positive number argument."
        exit 1
    fi
    if ! [[ $DAY_AGO =~ $re ]] ; then
        echo "ERR: -d option requires on a number argument."
        exit 1
    fi
}

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

validate_params
echo "COMMIT_CNT is ${COMMIT_CNT} DAY_AGO is ${DAY_AGO}"

#make_dummy_change
#update_current_date
#commit_with_current_date

