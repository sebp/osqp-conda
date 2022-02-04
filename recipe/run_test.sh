#!/bin/bash
set -e

tests_path=$($PYTHON -c "from os.path import join; import osqp; print(join(osqp.__path__[0], 'tests'))")
$PYTHON -m pytest "${tests_path}" -k "not codegen"
