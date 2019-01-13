@echo off

set GPU_FORCE_64BIT_PTR=1
set GPU_USE_SYNC_OBJECTS=1
set GPU_MAX_ALLOC_PERCENT=100
set GPU_SINGLE_ALLOC_PERCENT=100
set GPU_MAX_HEAP_SIZE=100

:loop
wildrig.exe --algo mtp --opencl-threads 1 --opencl-launch 16x0 --url stratum+tcp://xzc.2miners.com:8080 --user aKwUYjE3RhP5AQCnusi6SPGMD9uobZGHaf --pass x
if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop