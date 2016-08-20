#!/usr/bin/env bash

# get resources:

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
pushd "$DIR">/dev/null

# ------------------------------------------------------------
#* C/C++ flex

files=()

# repos
declare -A repos=( 
    ["https://github.com/nverno/flex-mode"]="flex-mode"
    ["https://github.com/nverno/bison-mode"]="bison-mode"
)

# get files
get_resource_files () {
    for f in ${files[@]}; do
        if [[ ! -f $(basename $f) ]]; then
            wget $f
        fi
    done
}

# get / update resource repos
get_resource_repos () {
    for repo in "${!repos[@]}"; do
        if [[ ! -d "${repos["$repo"]}" ]]; then
            git clone --depth 1 "$repo" "${repos["$repo"]}"
        else
            pushd "${repos["$repo"]}">/dev/null
            git pull --depth 1
            popd>/dev/null
        fi
    done
}

# ------------------------------------------------------------
#* SML
# Tiger compiler
# SML-lex tool
sml_tiger_bundle="http://www.cs.princeton.edu/~appel/modern/ml/tiger.tar"

get_sml_tiger_compiler () {
    wget "$sml_tiger_bundle"
    7za x tiger.tar
    rm tigar.tar
}

# ------------------------------------------------------------
# get stuff

# [[ ! -f "blah" ]] && get_resource_files

get_resource_repos

popd>/dev/null

# Local Variables:
# sh-shell: bash
# End:
