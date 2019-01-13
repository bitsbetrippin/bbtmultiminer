@echo off

:loop
wildrig.exe --algo sha256q --opencl-threads 1 --opencl-launch 29x0 --url stratum+tcp://stratum-eu.coin-miners.info:3340 --user PPwVccdQxum5b8FfLWztZHCeSgUr1R3q9z --pass c=PYE
if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop