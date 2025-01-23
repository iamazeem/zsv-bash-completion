#!/usr/bin/env bash

GLOBAL_FLAGS="
    -L
    -c
    -r
    -B
    -t
    -O
    -q
    -R
    -d
    -u
    -S
    -0
    -v
    --limit-rows
    --max-column-count
    --max-row-size
    --buff-size
    --tab-delim
    --other-delim
    --no-quote
    --skip-head
    --header-row-span
    --malformed-utf8-replacement
    --keep-blank-headers
    --header-row
    --verbose
"

declare -A COMMANDS=(
    [_zsv]="
        version
        help
        register
        unregister
        thirdparty
        license
        select
        echo
        sql
        count
        desc
        pretty
        flatten
        2json
        2tsv
        serialize
        stack
        compare
        2db
        prop
        rm
        mv
        jq
    "
    [_version]=""
    [_help]=""
    [_register]=""
    [_unregister]=""
    [_thirdparty]=""
    [_license]=""
    [_select]="$GLOBAL_FLAGS"
    [_echo]="$GLOBAL_FLAGS"
    [_sql]="$GLOBAL_FLAGS"
    [_count]="$GLOBAL_FLAGS"
    [_desc]="$GLOBAL_FLAGS"
    [_pretty]="$GLOBAL_FLAGS"
    [_flatten]="$GLOBAL_FLAGS"
    [_2json]="$GLOBAL_FLAGS"
    [_2tsv]="$GLOBAL_FLAGS"
    [_serialize]="$GLOBAL_FLAGS"
    [_stack]="$GLOBAL_FLAGS"
    [_compare]="$GLOBAL_FLAGS"
    [_2db]="$GLOBAL_FLAGS"
    [_prop]=""
    [_rm]=""
    [_mv]=""
    [_jq]=""
)

_zsv() {
    COMPREPLY=()
    if ((COMP_CWORD == 1)); then
        COMPREPLY=($(compgen -W "${COMMANDS[_zsv]}" -- "${COMP_WORDS[1]}"))
    elif ((COMP_CWORD >= 2)) && [[ ${COMP_WORDS[$COMP_CWORD]} == -* ]]; then
        local SUBCOMMAND="${COMP_WORDS[1]}"
        if [[ -n ${COMMANDS[_$SUBCOMMAND]} ]]; then
            COMPREPLY=($(compgen -W "${COMMANDS[_$SUBCOMMAND]}" -- "${COMP_WORDS[$COMP_CWORD]}"))
        fi
    fi
}

complete -o bashdefault -o default -F _zsv zsv
