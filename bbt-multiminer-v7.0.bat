@echo off
SETLOCAL EnableDelayedExpansion
rem **********************************************************************
rem *         BBT Multi-Miner Easy Batch File  v7.0 by BBT Carter        *
rem **********************************************************************
rem * BEST VIEWED IN FULL SCREEN 1920x1080
rem **********************************************************************

CALL my_info.bat

::SET Intensity Globally
SET I=20
::SET Thread Concurrency Globally
SET TC=1024
::GPU Platform (AMD) Options 0 or 1
SET Platform=1

:: Environmental Variables
SETX GPU_FORCE_64BIT_PTR 0 >nul 2>&1
SETX GPU_MAX_HEAP_SIZE 100 >nul 2>&1
SETX GPU_USE_SYNC_OBJECTS 1 >nul 2>&1
SETX GPU_MAX_ALLOC_PERCENT 100 >nul 2>&1
SETX GPU_SINGLE_ALLOC_PERCENT 100 >nul 2>&1

SET miner=%1
IF NOT "%miner%"=="" (
    SET /A M=%miner%
    GOTO MinerSwitch
)
ECHO =========================================================================
ECHO *                           ETHASH ALGORITHM                            *
ECHO =========================================================================
ECHO 1.  Ethereum          (ETH)   Ethermine.org      AMD/NVIDIA Claymore 11.9
ECHO 2.  Ethereum          (ETH)   Nanopool.org       AMD/NVIDIA Claymore 11.9
ECHO 3.  Ethereum Classic  (ETC)   Ethermine.org      AMD/NVIDIA Claymore 11.9
ECHO 4.  Ethereum Classic  (ETC)   Nanopool.org       AMD/NVIDIA Claymore 11.9
ECHO 5.  Ubiq              (UBQ)   ubiq.HODLPool      AMD/NVIDIA Claymore 11.9
ECHO 6.  Musicoin          (MUS)   Coinmine.pl        AMD/NVIDIA Claymore 11.9
ECHO 7.  Musicoin          (MUS)   Miningpoolhub.com  AMD/NVIDIA Claymore 11.9
ECHO 8.  Pirl             (PIRL)   HPPCG Pool         AMD/NVIDIA Claymore 11.9
ECHO 9.  Pirl             (PIRL)   cryptopools.info   0-150 MH/s    AMD/NVIDIA Claymore 11.9
ECHO 10. Pirl             (PIRL)   cryptopools.info   150-800 MH/s  AMD/NVIDIA Claymore 11.9
ECHO 11. Pirl             (PIRL)   cryptopools.info   800+ MH/s     AMD/NVIDIA Claymore 11.9
ECHO 12. Expanse           (EXP)   expmine.pro                      AMD/NVIDIA Claymore 11.9
ECHO 13. Ellaism          (ELLA)   ellaismpool        0-150 MH/s    AMD/NVIDIA Claymore 11.9
ECHO 14. Ellaism          (ELLA)   ellaismpool        150-800 MH/s  AMD/NVIDIA Claymore 11.9
ECHO 15. Ellaism          (ELLA)   ellaismpool        800+ MH/s     AMD/NVIDIA Claymore 11.9
ECHO 16. Ellaism          (ELLA)   minerpool.net      0-100 MH/s    AMD/NVIDIA Claymore 11.9
ECHO 17. Ellaism          (ELLA)   minerpool.net      100-800 MH/s  AMD/NVIDIA Claymore 11.9
ECHO 18. Ellaism          (ELLA)   minerpool.net      800+ MH/s     AMD/NVIDIA Claymore 11.9
ECHO 19. Akroma           (AKA)    2miners.com        AMD/NVIDIA Claymore 11.9
ECHO =========================================================================
ECHO *                           EQUIHASH ALGORITHM                          *
ECHO =========================================================================
ECHO 20.  ZCash            (ZEC)  Nanopool.org        AMD ZCash Claymore 12.6
ECHO 21.  ZCash            (ZEC)  Nanopool.org        NVIDIA DSTM 0.6.1 ZMiner
ECHO 22.  Komodo           (KMD)  Suprnova.cc         AMD Claymore 12.6
ECHO 23.  Komodo           (KMD)  Suprnova.cc         NVIDIA DSTM 0.6.1 ZMiner
ECHO 24.  Bitcoin Private (BTCP)  btcprivate.org      AMD Claymore 12.6
ECHO 25.  Bitcoin Private (BTCP)  btcprivate.org      NVIDIA DSTM 0.6.1 ZMiner
ECHO 26.  Zclassic         (ZCL)  miningpoolhub.com   AMD Claymore 12.6
ECHO 27.  Zclassic         (ZCL)  miningpoolhub.com   NVIDIA DSTM 0.6.1 ZMiner
ECHO 28.  ZenCash          (ZEN)  suprnova.cc         AMD Claymore 12.6
ECHO 29.  ZenCash          (ZEN)  suprnova.cc         NVIDIA DSTM 0.6.1 ZMiner
ECHO 30.  ZenCash          (ZEN)  zhash.pro           AMD Claymore 12.6
ECHO 31.  ZenCash          (ZEN)  zhash.pro           NVIDIA DSTM 0.6.1 ZMiner
ECHO =========================================================================
ECHO *                           LYRA2Z ALGORITHM                            *
ECHO =========================================================================
ECHO 32.  Zcoin            (XZC)  Miningpoolhub.com   NVIDIA Nevermore 0.2.3
ECHO 33.  Zcoin            (XZC)  Miningpoolhub.com   AMD Avermore 1.4.1
ECHO =========================================================================
ECHO *                          NEOSCRYPT ALGORITHM                          *
ECHO =========================================================================
ECHO 34.  Feathercoin      (FTC)  F2Pool              NVIDIA Nevermore 0.2.3
ECHO 35.  Feathercoin      (FTC)  F2Pool              AMD NSGMiner 0.9.2
ECHO =========================================================================
ECHO *                       MYRIAD-GROESTLE ALGORITHM                       *
ECHO =========================================================================
ECHO 36.  Digibyte         (DGB)  Suprnova.cc         AMD Avermore 1.4.1
ECHO 37.  Digibyte         (DGB)  Suprnova.cc         NVIDIA Nevermore 0.2.3
ECHO =========================================================================
ECHO *                       CRYPTONIGHT V7 ALGORITHM                        *
ECHO =========================================================================
ECHO 38.  Monero           (XMR)  Nanopool.org        NVIDIA XMRig 2.5.2
ECHO 39.  Monero           (XMR)  Nanopool.org        AMD Claymore CryptoNote 11.3
ECHO 40.  Monero           (XMR)  Nanopool.org        AMD CAST XMR Vega Miner 0.9.2
ECHO =========================================================================
ECHO *                         CRYPTONIGHT ALGORITHM                         *
ECHO =========================================================================
ECHO 41.  Electroneum      (ETN)  Easyhash.io         NVIDIA XMRig 2.5.2
ECHO 42.  Electroneum      (ETN)  Easyhash.io         AMD Claymore CryptoNote 11.3
ECHO 43.  Electroneum      (ETN)  Easyhash.io         AMD CAST XMR Vega Miner 0.9.2
ECHO 44.  Sumokoin        (SUMO)  Easyhash.io         NVIDIA XMRig 2.5.2
ECHO 45.  Sumokoin        (SUMO)  Easyhash.io         AMD Claymore CryptoNote 11.3
ECHO 46.  Sumokoin        (SUMO)  Easyhash.io         AMD CAST XMR Vega Miner 0.9.2
ECHO 47.  Karbowanec       (KRB)  Cryptoknight.cc     NVIDIA XMRig 2.5.2
ECHO 48.  Karbowanec       (KRB)  Cryptoknight.cc     AMD Claymore CryptoNote 11.3
ECHO 49.  Karbowanec       (KRB)  Cryptoknight.cc     AMD CAST XMR Vega Miner 0.9.2
ECHO 50.
ECHO 51.
ECHO =========================================================================
ECHO *                            X16R ALGORITHM                             *
ECHO =========================================================================
ECHO 52.  Ravencoin        (RVN)  Ravenminer.com      AMD Avermore 1.4.1
ECHO 53.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA Nevermore 0.2.3
ECHO 54.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA Enemy 1.3.0
ECHO 55.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA Suprminer 1.6.0
ECHO =========================================================================
ECHO *                            X16S ALGORITHM                             *
ECHO =========================================================================
ECHO 56.  Pigeoncoin       (PGN)  Blockcruncher       AMD Avermore 1.4.1
ECHO 57.  Pigeoncoin       (PGN)  Blockcruncher       NVIDIA Nevermore 0.2.3
ECHO =========================================================================
ECHO *                          LYRA2REV2 ALGORITHM                          *
ECHO =========================================================================
ECHO 58.  Vertcoin         (VTC)  Miningpoolhub.com   AMD Avermore 1.4.1
ECHO 59.  Vertcoin         (VTC)  Miningpoolhub.com   NVIDIA Nevermore 0.2.3
ECHO =========================================================================
ECHO *                           LYRA2Z ALGORITHM                            *
ECHO =========================================================================
ECHO 60.  MonaCoin        (MONA)  Miningpoolhub.com   AMD Avermore 1.4.1
ECHO 61.  MonaCoin        (MONA)  Miningpoolhub.com   NVIDIA Nevermore 0.2.3
ECHO *************************************************************************
ECHO 99.  EXIT

:MinerSwitch
:: Get input from user
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %ERRORLEVEL% NEQ 0 GOTO EOF

:: Is choice a number?
SET "var="&for /f "delims=0123456789" %%i in ("%M%") do SET var=%%i
IF DEFINED var GOTO EOF

IF %M%==1 GOTO ETH1
IF %M%==2 GOTO ETH2
IF %M%==3 GOTO ETC1
IF %M%==4 GOTO ETC2
IF %M%==5 GOTO UBQ1
IF %M%==6 GOTO MUS1
IF %M%==7 GOTO MUS2
IF %M%==8 GOTO PIRL1
IF %M%==9 GOTO PIRL2
IF %M%==10 GOTO PIRL3
IF %M%==11 GOTO PIRL4
IF %M%==12 GOTO EXP1
IF %M%==13 GOTO ELLA1
IF %M%==14 GOTO ELLA2
IF %M%==15 GOTO ELLA3
IF %M%==16 GOTO ELLA4
IF %M%==17 GOTO ELLA5
IF %M%==18 GOTO ELLA6
IF %M%==19 GOTO AKA
IF %M%==20 GOTO ZEC1
IF %M%==21 GOTO ZEC2
IF %M%==22 GOTO KMD1
IF %M%==23 GOTO KMD2
IF %M%==24 GOTO BTCP1
IF %M%==25 GOTO BTCP2
IF %M%==26 GOTO ZCL1
IF %M%==27 GOTO ZCL2
IF %M%==28 GOTO ZEN1
IF %M%==29 GOTO ZEN2
IF %M%==30 GOTO ZEN3
IF %M%==31 GOTO ZEN4
IF %M%==32 GOTO XZC1
IF %M%==33 GOTO XZC2
IF %M%==34 GOTO FTC1
IF %M%==35 GOTO FTC2
IF %M%==36 GOTO DGB1
IF %M%==37 GOTO DGB2
IF %M%==38 GOTO XMR1
IF %M%==39 GOTO XMR2
IF %M%==40 GOTO XMR3
IF %M%==41 GOTO ETN1
IF %M%==42 GOTO ETN2
IF %M%==43 GOTO ETN3
IF %M%==44 GOTO SUMO1
IF %M%==45 GOTO SUMO2
IF %M%==46 GOTO SUMO3
IF %M%==47 GOTO KRB1
IF %M%==48 GOTO KRB2
IF %M%==49 GOTO KRB3
IF %M%==50 GOTO EOF
IF %M%==51 GOTO EOF
IF %M%==52 GOTO RVN1
IF %M%==53 GOTO RVN2
IF %M%==54 GOTO RVN3
IF %M%==55 GOTO RVN4
IF %M%==56 GOTO PGN1
IF %M%==57 GOTO PGN2
IF %M%==58 GOTO VTC1
IF %M%==59 GOTO VTC2
IF %M%==60 GOTO MONA1
IF %M%==61 GOTO MONA2
IF %M%>61 GOTO EOF

::
:: Ethereum miners
::
:ETH1
ECHO AMD and NVIDIA Claymore 11.9 - Eth Only Ethermine.org
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool us1.ethermine.org:4444 -ewal %ETH%.%MINER_NAME% -epsw %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ETH2
ECHO AMD and NVIDIA Claymore 11.9 - Eth Only Nanopool.org
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool eth-us-east1.nanopool.org:9999 -ewal %ETH%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ethereum Classic miners
::
:ETC1
ECHO AMD and NVIDIA Claymore 11.9 - Etc (ethereum classic) etc.ethermine.org
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool us1-etc.ethermine.org:4444 -ewal %ETC%.%MINER_NAME% -epsw %WORKER_PASSWORD% -mode 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ETC2
ECHO AMD and NVIDIA Claymore 11.9 - Etc (ethereum classic) to Nanopool
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool etc-us-east1.nanopool.org:19999 -ewal %ETC%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ubiq Miners
::
:UBQ1
ECHO AMD and NVIDIA Claymore 11.9 - Ubiq to Hodl Pool Only
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBQ% -epsw x -eworker %MINER_NAME% -allpools 1 -allcoins 1 -mode 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Musicoin Miners
::
:MUS1
ECHO AMD and NVIDIA Claymore 11.9 - Musicoin to Coinmine.pl
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool music.coinmine.pl:2020 -ewal %MUS%.%MINER_NAME% -dpsw x -mode 1 -allcoins 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:MUS2
ECHO AMD and NVIDIA Claymore 11.9 - Musicoin to miningpoolhub Pool Only
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Pirl Miners
::
:PIRL1
ECHO AMD and NVIDIA Claymore 11.9 - Pirl to HPPCG Pool
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://us-nj-01.pools.hppcg.com:8005 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PIRL2
ECHO AMD and NVIDIA Claymore 11.9 - Pirl 0-150 MH/s Cryptopools.info
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://pirl.cryptopools.info:8002 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PIRL3
ECHO AMD and NVIDIA Claymore 11.9 - Pirl 150-800 MH/s Cryptopools.info
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://pirl.cryptopools.info:8004 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PIRL4
ECHO AMD and NVIDIA Claymore 11.9 - Pirl 800+ MH/s Cryptopools.info
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://pirl.cryptopools.info:8008 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Expanse Miner
::
:EXP1
ECHO AMD and NVIDIA Claymore 11.9 - Expanse to expmine.pro
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://us.expmine.pro:9009 -ewal %EXP% -epsw %WORKER_PASSWORD% -esm 0 -allcoins 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ellaism Miners
::
:ELLA1
ECHO AMD and NVIDIA Claymore 11.9 - Ella 0-150 MH/s ellaismpool
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://ellaismpool.com:8008 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA2
ECHO AMD and NVIDIA Claymore 11.9 - Ella 150-800 MH/s ellaismpool
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://ellaismpool.com:8004 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA3
ECHO AMD and NVIDIA Claymore 11.9 - Ella 800+ MH/s ellaismpool
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://ellaismpool.com:8009 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA4
ECHO AMD and NVIDIA Claymore 11.9 - Ella 0-100 MH/s minerpool.net
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://lb.geo.ellapool.eu:8002 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA5
ECHO AMD and NVIDIA Claymore 11.9 - Ella 100-800 MH/s minerpool.net
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://lb.geo.ellapool.eu:8004 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA6
ECHO AMD and NVIDIA Claymore 11.9 - Ella 800+ MH/s minerpool.net
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool stratum+tcp://lb.geo.ellapool.eu:8009 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Akroma Miners
::
:AKA
ECHO AMD and NVIDIA Claymore 11.9 - Akroma to 2miners
Miners\Claymore_ETH_Miner_v11.9\EthDcrMiner64 -epool aka.2miners.com:5050 -ewal %AKA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: ZCash Miners
::
:ZEC1
ECHO ZCash Claymore - Zcash to Nanopool.org AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64 -zpool ssl://zec-us-east1.nanopool.org:6633 -zwal %ZEC%.%MINER_NAME%/%EMAIL_ADDRESS% -zpsw %WORKER_PASSWORD% -ftime 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ZEC2
ECHO NVIDIA DSTM Zcash Miner - Zcash to Nanopool.org NVIDIA Only
Miners\zm_0.6.1_win\zm --server zec-us-east1.nanopool.org --port 6666 --user %ZEC% --pass %WORKER_PASSWORD%  --color
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Komodo Miners
::
:KMD1
ECHO Claymore AMD - Komodo to Suprnova.cc
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64 -zpool stratum+tcp://kmd.suprnova.cc:6250 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:KMD2
ECHO NVIDIA DSTM ZMiner - Komodo to Suprnova.cc
Miners\zm_0.6.1_win\zm --server kmd.suprnova.cc  --port 6250 --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD% --color
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Bitcoin Private Miners
::
:BTCP1
ECHO Claymore AMD - BTCP to btcprivate.org
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64 -zpool pool2.btcprivate.org:3032 -zwal %BTCP% -zpsw %WORKER_PASSWORD% -ftime 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:BTCP2
ECHO NVIDIA DSTM Miner - BTCP to btcprivate.org
Miners\zm_0.6.1_win\zm --server pool2.btcprivate.org --port 3032 --user %BTCP% --pass %WORKER_PASSWORD% --color
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Zclassic Miners
::
:ZCL1
ECHO ZClassic Claymore - Zclassic to miningpoolhub - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64 -zpool us-east.equihash-hub.miningpoolhub.com:20575 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ZCL2
ECHO NVIDIA DSTM Miner - Zclassic to miningpoolhub
Miners\zm_0.6.1_win\zm --server us-east.equihash-hub.miningpoolhub.com --port 20575 --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD%  --color
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: ZenCash Miners
::
:ZEN1
ECHO ZENCoin Claymore - ZENCash to Suprnova.cc - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64 -zpool stratum+tcp://zen.suprnova.cc:3618 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ZEN2
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCash to Suprnova.cc
Miners\zm_0.6.1_win\zm --dev --server zen.suprnova.cc --port 3618 --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD% --color
IF %ERRORLEVEL% NEQ 0 GOTO exit
:ZEN3
ECHO ZENCoin Claymore - ZENCash to Zhash.pro - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64 -zpool us1.zhash.pro:3059 -zwal %ZEN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ZEN4
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCash to Zhash.pro
Miners\zm_0.6.1_win\zm --dev --server us1.zhash.pro --port 3059 --user %ZEN%.%MINER_NAME% --pass %WORKER_PASSWORD% --color
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Zcoin Miners
::
:XZC1
ECHO Nevermore 0.2.3 - Nvidia Only - Zcoin to Miningpoolhub.com
Miners\nevermore-v0.2.3-win64\ccminer -a lyra2z -o stratum+tcp://us-east.lyra2z-hub.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:XZC2
ECHO AMD Avermore 1.4.1 - Zcoin to Miningpoolhub.com
cd Miners\avermore-windows-1.4.1
sgminer -k lyra2 -o stratum+tcp://us-east.lyra2z-hub.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: FTC Miners
::
:FTC1
ECHO Nevermore 0.2.3 - Nvidia Only - FTC to P2Pool FTC
Miners\nevermore-v0.2.3-win64\ccminer -a neoscrypt -o stratum+tcp://46.4.0.101:19327 -u %FTC% -p %WORKER_PASSWORD%  -N60 -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:FTC2
ECHO AMD NSGMiner Feathercoin Miner - FTC to P2Pool FTC
cd Miners\nsgminer-win64-0.9.2
nsgminer --neoscrypt -w 128 -I d -o stratum+tcp://46.4.0.101:19327 -O %FTC%:%WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Digibyte Miners
::
:DGB1
ECHO AMD Avermore 1.4.1 GROESTL - Digibyte to Suprnova.cc
cd Miners\avermore-windows-1.4.1
sgminer -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I %I% -g 4 -w 128 -k myriadcoin-groestl --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:DGB2
ECHO Nevermore 0.2.3 - Nvidia Only - Digibyte to Suprnova.cc
Miners\nevermore-v0.2.3-win64\ccminer -a myr-gr -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Monero Miners
::
:XMR1
ECHO XMRig 2.5.2 NVIDIA - XMR to Nanopool.org
Miners\cryptonight\XMR\xmrig-NVIDIA-2.5.2-Win64\xmrig-NVIDIA
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:XMR2
ECHO AMD Claymore CryptoNote 11.3 - XMR to Nanopool
Miners\Claymore_CryptoNote_AMD_v11.3\NsGpuCNMiner -xpool ssl://xmr-us-east1.nanopool.org:14433 -xwal %XMR%.%MINER_NAME%/%EMAIL_ADDRESS% -xpsw x -allpools 1 -pow7 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:XMR3
ECHO CAST XMR Vega 0.9.2 - XMR to Nanopool.org for RX VEGA
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S xmr-us-east1.nanopool.org:14444 -u %XMR%.%MINER_NAME% -p x -a 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Electroneum Miners
::
:ETN1
ECHO XMRig 2.5.2 NVIDIA - Electroneum to Easyhash.io
Miners\cryptonight\ETN\xmrig-NVIDIA-2.5.2-Win64\xmrig-NVIDIA
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ETN2
ECHO AMD Claymore CryptoNote 11.3 - Electroneum to Easyhash.io
Miners\Claymore_CryptoNote_AMD_v11.3\NsGpuCNMiner -xpool ssl://etn.easyhash.io:3633 -xwal %ETN%+%MINER_NAME% -xpsw x -di 0123456789 -ftime 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ETN3
ECHO CAST XMR Vega 0.9.2 - XMR to Electroneum to Easyhash.io
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S etn.easyhash.io:3632 -u %ETN%+%MINER_NAME% -p x -a 0
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Sumokoin Miners
::
:SUMO1
ECHO XMRig 2.5.2 NVIDIA - Sumo to Easyhash.io
Miners\cryptonight\SUMO\xmrig-NVIDIA-2.5.2-Win64\xmrig-NVIDIA
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:SUMO2
ECHO AMD Claymore CryptoNote 11.3 - Sumo to Easyhash.io
Miners\Claymore_CryptoNote_AMD_v11.3\NsGpuCNMiner -xpool ssl://sumo.easyhash.io:3333 -xwal %SUMO%+%MINER_NAME% -xpsw x
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:SUMO3
ECHO CAST XMR Vega 0.9.2 - Sumo to easyhash.io
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S sumo.Easyhash.io:3332 -u %SUMO%+%MINER_NAME% -p x -a 0
PAUSE
::
:: Karbowanec Miners
::
:KRB1
ECHO XMRig 2.5.5 NVIDIA - Sumo to easyhash.io  - Karbowanec to Cryptoknight.cc
Miners\cryptonight\KARB\xmrig-NVIDIA
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:KRB2
ECHO AMD Claymore CryptoNote 11.3 - Karbowanec to Cryptoknight.cc
Miners\Claymore_CryptoNote_AMD_v11.3\NsGpuCNMiner -xpool stratum+tcp://karbo.ingest.cryptoknight.cc:29991 -xwal %KRB% -xpsw x
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:KRB3
ECHO CAST XMR Vega 0.9.2 - Karbowanec Cryptoknight.cc
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S karbo.ingest.cryptoknight.cc:29992 -u %KRB% -p x -a 0
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ravencoin Miners
::
:RVN1
ECHO AMD Avermore 1.4.1 - RavenCoin to Ravenminer.com
cd Miners\avermore-windows-1.4.1
sgminer -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% -k x16r --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:RVN2
ECHO Nevermore 0.2.3 - Nvidia Only - RavenCoin to Ravenminer.com
Miners\nevermore-v0.2.3-win64\ccminer -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:RVN3
ECHO Enemy 1.3.0 - Nvidia Only - RavenCoin to Ravenminer.com
Miners\Enemy-ccminer.1.3.0\ccminer -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:RVN4
ECHO Suprminer 1.6.0 - Nvidia Only - RavenCoin to Ravenminer.com
Miners\suprminer-1.6\ccminer -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Pigeoncoin Miners
::
:PGN1
ECHO AMD Avermore 1.4.1 - Pigeoncoin to Blockcruncher
cd Miners\avermore-windows-1.4.1
sgminer -k x16s -o stratum+tcp://blockcruncher.com:3636 -u %PGN% -p %WORKER_PASSWORD% -I %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PGN2
ECHO Nevermore 0.2.3 - Nvidia Only - Pigeoncoin to Blockcruncher
Miners\nevermore-v0.2.3-win64\ccminer -a x16s -o stratum+tcp://blockcruncher.com:3636 -u %PGN% -p %WORKER_PASSWORD% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Vertcoin Miner
::
:VTC1
ECHO AMD Avermore 1.4.1 - Vertcoin to Suprnova.cc
cd Miners\avermore-windows-1.4.1
sgminer -o stratum+tcp://vtc.suprnova.cc:5678 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -k lyra2rev2 --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:VTC2
ECHO Nevermore 0.2.3 - Nvidia Only - Vertcoin to Miningpoolhub
Miners\nevermore-v0.2.3-win64\ccminer -a Lyra2rev2 -o stratum+tcp://hub.miningpoolhub.com:20507 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: MonaCoin Miners
::
:MONA1
ECHO AMD Avermore 1.4.1 - MonaCoin to miningpoolhub.com
cd Miners\avermore-windows-1.4.1
sgminer -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p x -k lyra2rev2 --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:MONA2
ECHO Nevermore 0.2.3 - Nvidia Only - Monacoin to Miningpoolhub
Miners\nevermore-v0.2.3-win64\ccminer -a Lyra2rev2 -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:EOF
