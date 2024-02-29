#!/usr/bin/env bash

MAIN_CMDS=(
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
)

MAIN_CMDS_WITHOUT_MAIN_FLAGS=(
    version
    help
    register
    unregister
    thirdparty
    license
    prop
    rm
    jq
)

MAIN_FLAGS=(
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
)

__zsv_completions() {
    if ((COMP_CWORD == 1)); then
        COMPREPLY=($(compgen -W "${MAIN_CMDS[*]}" -- "${COMP_WORDS[1]}"))
    elif ((COMP_CWORD >= 2)) && [[ ${COMP_WORDS[$COMP_CWORD]} == "-"* ]]; then
        if ! echo "${MAIN_CMDS_WITHOUT_MAIN_FLAGS[*]}" | grep -o -- "${COMP_WORDS[1]}" >/dev/null; then
            COMPREPLY=($(compgen -W "${MAIN_FLAGS[*]}" -- "${COMP_WORDS[$COMP_CWORD]}"))
        fi
    fi
}

complete -o bashdefault -o default -F __zsv_completions zsv
