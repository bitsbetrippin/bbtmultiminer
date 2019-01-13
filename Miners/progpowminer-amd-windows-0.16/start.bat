setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100
@echo off
REM # Edit the line below to be
REM # progpowminer-amd.exe -G -P stratum+tcp://<YOURBCIADDRESS>@<YOURPOOL>:<PORT>
REM # Example: 
progpowminer-amd.exe -G -P --opencl-platform 1 --cl-kernel 1 stratum+tcp://iRkg5CkvrRiuiGFufmQugfo5BdXwLhxvU5@eu-1.pool.bci-server.com:3869
pause