#!/bin/bash
set -e

test_methods="not codegen"

# the output of show_config() changes in 1.25
old_show_config=$(python -c 'from importlib.metadata import version; from packaging.version import Version, parse; print(parse(version("numpy")) < parse("1.25.0"))')

if [ "${old_show_config}" = "True" ]; then
  mkl_info=$($PYTHON -c 'import numpy; numpy.show_config()' | grep -A1 'blas_mkl_info' | tail -n 1 | tr -d ' ')
else
  mkl_info=$($PYTHON -c 'import numpy; numpy.show_config()' | grep -m 1 'name: mkl' || echo 'NOTAVAILABLE')
fi

if [ "${MACOSX_DEPLOYMENT_TARGET:-x}" != "x" -a "${mkl_info}" = "NOTAVAILABLE" ]; then
  test_methods="${test_methods} and not mkl_pardiso_tests"
fi
tests_path=$($PYTHON -c "from os.path import join; import osqp; print(join(osqp.__path__[0], 'tests'))")
$PYTHON -m pytest "${tests_path}" -k "${test_methods}"
