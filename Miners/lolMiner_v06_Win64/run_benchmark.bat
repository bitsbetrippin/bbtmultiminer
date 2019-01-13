@echo off

setlocal enableDelayedExpansion


setx GPU_FORCE_64BIT_PTR 1
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100

Start /b /wait lolMiner.exe --benchmark MNX --shortstats 5 --longstats 60
Start /b /wait lolMiner.exe --benchmark AION --shortstats 5 --longstats 60
Start /b /wait lolMiner.exe --benchmark BTG --shortstats 5 --longstats 60
Start /b /wait lolMiner.exe --benchmark ZER --shortstats 5 --longstats 60

timeout 10
