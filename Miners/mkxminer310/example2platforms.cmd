setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100

mkxminer.exe -o stratum+tcp://vtc.suprnova.cc:5678 -u bbttest.bbtworker01 -p x -I 23 --platform 1

pause