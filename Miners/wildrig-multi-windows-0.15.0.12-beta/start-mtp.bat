@echo off

set GPU_FORCE_64BIT_PTR=1
set GPU_USE_SYNC_OBJECTS=1
set GPU_MAX_ALLOC_PERCENT=100
set GPU_SINGLE_ALLOC_PERCENT=100
set GPU_MAX_HEAP_SIZE=100

wildrig -help
rem wildrig.exe --algo mtp --opencl-threads 1 --opencl-launch 16x0 --url stratum+tcp://xzc.2miners.com:8080 --user aKwUYjE3RhP5AQCnusi6SPGMD9uobZGHaf --pass x
pause

