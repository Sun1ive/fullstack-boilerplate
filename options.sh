#!/bin/bash

function choose_option() {
    local _prompt="$1"
    local _result
    shift
    if test "$#" -gt 0;
    then
        _prompt="${_prompt} [$1"
        shift
    fi
    while test "$#" -gt 0;
    do
        _prompt="${_prompt}/$1"
        shift
    done
    _prompt="${_prompt}] "
    read -p "${_prompt}" _result
    local _code=$?
    if test "${_code}" -eq 0;
    then
        echo "${_result}"
    else
        return ${_code}
    fi
}

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