#!/bin/bash

echo "Installing nestjs CLI"
selectionOpts=("With Database" "Without Database")

function choose_option_default() {
    local _prompt="$1"
    local _default="$2"
    local _options=()
    local i
    shift 2
    while test "$#" -gt 0;
    do
        _opts+=("$1")
        if test "$1" == "${_default}";
        then
            _options+=("${1^^}")
        else
            _options+=("${1,,}")
        fi
        shift
    done
    local _result=$(choose_option "${_prompt}" "${_options[@]}")
    if test -z "${_result}";
    then
        echo "${_default}"
        return 0
    else
        for ((i=0; i!=${#_options[@]}; ++i));
        do
            if test "${_result,,}" == "${_options[i],,}";
            then
                echo "${_opts[i],,}"
                return 0
            fi
        done
    fi
    return 1
}

function whatToInstall() {
    local _ans=$(choose_option_default "Would you like to install database module?" y y n)
    
    case "${_ans}" in
        [Yy]|[Yy][Ee][Ss])
            echo "Yes"
        ;;
        [Nn]|[Nn][Oo])
            echo "No"
        ;;
        *)
            echo "Invalid input"
        ;;
    esac
}

sudo npm i -g @nestjs/cli

nest new server

withDatabase=$(whatToInstall)

if [ $withDatabase == "Yes" ]
then
    cd server && npm
fi

