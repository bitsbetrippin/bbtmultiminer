setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100

mkxminer.exe -o stratum+tls://vtc.suprnova.cc:5676 -u WinMKX.test -p x -I 20

pause