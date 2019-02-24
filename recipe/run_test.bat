
echo on

for /F "tokens=* USEBACKQ" %%F in (
  `python -c "import osqp.tests; print(osqp.tests.__path__[0])`
) do (
  set TestsPath=%%F
)

python -m pytest %TestsPath% -k "not codegen"
