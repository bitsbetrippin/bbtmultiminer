setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100

mkxminer.exe --exitsick --asm -o stratum+tls://mona.suprnova.cc:3001 -u WinMKX.test -p x -I 23

pause