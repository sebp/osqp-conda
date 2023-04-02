#!/bin/bash
set -e

test_methods="not codegen"
if [ "${MACOSX_DEPLOYMENT_TARGET:-x}" != "x" -a "${STDLIB_DIR%3.11}" != "${STDLIB_DIR}" ]; then
  test_methods="${test_methods} and not mkl_pardiso_tests"
fi
tests_path=$($PYTHON -c "from os.path import join; import osqp; print(join(osqp.__path__[0], 'tests'))")
$PYTHON -m pytest "${tests_path}" -k "${test_methods}"
