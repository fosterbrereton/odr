#!/usr/bin/env bash
set -euo pipefail

function join_by { local d=${1-} f=${2-}; if shift 2; then printf %s "$f" "${@/#/$d}"; fi; }

DIR_ROOT=$(dirname "${BASH_SOURCE[0]}")
CONFIGURATION=Debug # Debug / Release

pushd ${DIR_ROOT} > /dev/null

if [ ! -e "./build" ]; then
    mkdir build
fi

CXX_OPTIONS_ARRAY=(
    -x
    c++
    -g
    -std=c++17
    -stdlib=libc++
    -fsanitize=address
    -fno-omit-frame-pointer
    -I./include/
)
CXX_OPTIONS=$(join_by ' ' "${CXX_OPTIONS_ARRAY[@]}")

set -x
clang++ ${CXX_OPTIONS} -c ./src/foo.cpp -o ./build/foo.o 
clang++ ${CXX_OPTIONS} -c ./src/bar.cpp -o ./build/bar.o 
clang++ ${CXX_OPTIONS} -c ./src/main.cpp -o ./build/main.o
# The output of the sample app will change based on the order in which the object files are passed.
clang++ -fsanitize=address ./build/main.o ./build/foo.o ./build/bar.o  -o ./build/odr
set +x

# Enable/disable asan parameters by (un-)commenting them out; they will be included or elided from
# the `ASAN_OPTIONS` env var construction, respectively.
ASAN_OPTION_ARRAY=(
    # help=1                        # dump possible asan flags/settings/etc. to stdout
    verbosity=3                     # asan verbose output
    # use_odr_indicator=1           # unrecognized flag?
    detect_odr_violation=2          # detect ODR violations
    # suppressions="asan.supp"      # asan suppressions file (if needed)
)

ASAN_OPTIONS=$(join_by : "${ASAN_OPTION_ARRAY[@]}")

set -x
ASAN_OPTIONS=${ASAN_OPTIONS} ./build/odr
set +x
