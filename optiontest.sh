#!/bin/sh

YEAR=""
MONTH=""
DAY=""

function validate_params() {
    if [ x$YEAR == x ];then
        echo $YEAR
        echo >&2 "ERR: YEAR requires on argument."
        exit 1
    fi
    if [ x${MONTH} == x ];then
        echo >&2 "ERR: MONTH requires on argument."
        exit 1
    fi
    if [ x${DAY} == x ];then
        echo >&2 "ERR: DAY requires on argument."
        exit 1
    fi
}

while getopts "y:m:d:" opt; do
    case $opt in
        y)
            YEAR=$OPTARG
            ;;
        m)
            MONTH=$OPTARG
            ;;
        d)
            DAY=$OPTARG
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

validate_params

echo ${YEAR} ${MONTH} ${DAY}
