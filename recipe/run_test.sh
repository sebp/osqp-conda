#!/bin/bash
set -e

tests_path=$($PYTHON -c "import osqp.tests; print(osqp.tests.__path__[0])")
$PYTHON -m pytest "${tests_path}" -k "not codegen and not update_matrices_tests"
