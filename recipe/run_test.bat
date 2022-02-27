
echo on

for /F "tokens=* USEBACKQ" %%F in (
  `python -c "from os.path import join; import osqp; print(join(osqp.__path__[0], 'tests'))`
) do (
  set TestsPath=%%F
)

copy /V /Y /B "%LIBRARY_BIN%\\mkl_rt.1.dll" "%LIBRARY_BIN%\\mkl_rt.dll"

python -m pytest %TestsPath% -k "not codegen"
