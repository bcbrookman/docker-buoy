#!/bin/bash

PROJ_ROOT=$(dirname -- "$(readlink -f "${BASH_SOURCE}")")

function test:install-depends {
    set -o xtrace
    pip install pylint pytest coverage
    pip install -r requirements.txt
}

function test:lint {
    set -o xtrace
    pylint $PROJ_ROOT/app.py
}

function test:units {
    set -o xtrace
    coverage run --source="$PROJ_ROOT/" -m pytest "$PROJ_ROOT/" 
    coverage report --omit test_* --fail-under=90
}

function help {
    echo "$0 [-e] TASK [ARGS]"
    echo "Tasks:"
    compgen -A function | grep -v ^_ | cat -n
}

# If -e is set as the first argument, exit the script
# when a failure occurs (necessary for CI/CD)
if [ "$1" = "-e" ]; then
    set -e
    shift 1
fi

TIMEFORMAT="Task completed in %3lR"
time ${@:-help}