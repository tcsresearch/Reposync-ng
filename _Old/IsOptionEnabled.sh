#!/bin/bash

VAR="enabled"

case "$VAR" in
    y|yes|true|enabled|on|1)
        echo "Variable is a 'true' value."
        ;;
    n|no|false|disabled|off|0)
        echo "Variable is a 'false' value."
        ;;
    *)
        echo "Variable is something else."
        ;;
esac

