@echo off

:loop
wildrig.exe --algo sha256t --opencl-threads 1 --opencl-launch 29x0 --url stratum+tcp://blockmasters.co:3339 --user LggMMxFuNMhkHF6SF9dX5Zi4x8SGnCht2g --pass c=LTC
if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop