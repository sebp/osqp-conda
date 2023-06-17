#!/bin/bash
set -e

test_methods="not codegen"
mkl_info=$(python -c 'import numpy; numpy.show_config()' | grep -A1 'blas_mkl_info' | tail -n 1 | tr -d ' ')
if [ "${MACOSX_DEPLOYMENT_TARGET:-x}" != "x" -a "${mkl_info}" = "NOTAVAILABLE" ]; then
  test_methods="${test_methods} and not mkl_pardiso_tests"
fi
tests_path=$($PYTHON -c "from os.path import join; import osqp; print(join(osqp.__path__[0], 'tests'))")
$PYTHON -m pytest "${tests_path}" -k "${test_methods}"
