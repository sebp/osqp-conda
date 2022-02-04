
echo on

for /F "tokens=* USEBACKQ" %%F in (
  `python -c "from os.path import join; import osqp; print(join(osqp.__path__[0], 'tests'))`
) do (
  set TestsPath=%%F
)

python -m pytest %TestsPath% -k "not codegen"
