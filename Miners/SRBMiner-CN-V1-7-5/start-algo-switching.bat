setx GPU_MAX_HEAP_SIZE 100
setx GPU_MAX_USE_SYNC_OBJECTS 1
setx GPU_SINGLE_ALLOC_PERCENT 100
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_MAX_SINGLE_ALLOC_PERCENT 100
@echo off
cd %~dp0

cls
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set LOGTIME=%dt:~0,4%_%dt:~4,2%_%dt:~6,2%_%dt:~8,2%_%dt:~10,2%_%dt:~12,2%
set LOGTIME=%LOGTIME: =%
set LOGTIME=%LOGTIME:,=.%.txt

SRBMiner-CN.exe --config Config\config-normalv8.txt --pools pools-algoswitch.txt --logfile algo_switching_%LOGTIME% --usealgoswitching