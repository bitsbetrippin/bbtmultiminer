REM
REM Example bat file for starting PhoenixMiner.exe to mine ETH
REM

setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100

REM IMPORTANT: Replace the ETH address with your own ETH wallet address in the -wal option (Rig001 is the name of the rig)
PhoenixMiner.exe -di 0 -pool ssl://eu1.ethermine.org:5555 -pool2 ssl://us1.ethermine.org:5555 -wal 0x008c26f3a2Ca8bdC11e5891e0278c9436B6F5d1E.Rig001
REM PhoenixMiner.exe -h


