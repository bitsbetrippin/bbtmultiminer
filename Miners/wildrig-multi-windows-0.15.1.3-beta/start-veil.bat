@echo off

:loop
wildrig.exe --algo x16rt --opencl-threads 2 --opencl-launch 21x0 --url stratum+tcp://veil.suprnova.cc:7220 --user andrucrypt.test --pass x
if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop