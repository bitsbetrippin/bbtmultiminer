@echo off

setlocal enableDelayedExpansion

Rem #################################
Rem ## Begin of user-editable part ##
Rem #################################

Rem Insert your configuration file name here
set "PROFILE=EXAMPLE_LEAFPOOL"										

Rem #################################
Rem ##  End of user-editable part  ##
Rem #################################


set "PARAMS=--profile %PROFILE%"

setx GPU_FORCE_64BIT_PTR 1
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100

lolMiner.exe !PARAMS! 
timeout 10

