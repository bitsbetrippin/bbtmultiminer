@echo off
SETLOCAL EnableDelayedExpansion
rem **********************************************************************
rem *         BBT Multi-Miner Easy Batch File  v8.0 by BBT Carter        *
rem **********************************************************************
rem * BEST VIEWED IN FULL SCREEN 1920x1080
rem **********************************************************************

CALL my_info.bat

::SET Intensity Globally
SET I=18
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
ECHO *  ** DISCLAIMER: SOME MINERS INCLUDED HAVE BUILT IN DEV FEES           *
ECHO *                 REVIEW DETAILS OF MINER under MINER FOLDER FOR INFO   *
ECHO =========================================================================
ECHO =========================================================================
ECHO *                           ETHASH/UBQHASH ALGORITHM                    *
ECHO =========================================================================
ECHO 1.  Ethereum          (ETH)   Ethermine.org      AMD/NVIDIA Claymore 12.0
ECHO 2.  Ethereum          (ETH)   Nanopool.org       AMD/NVIDIA Claymore 12.0
ECHO 3.  Ethereum Classic  (ETC)   Ethermine.org      AMD/NVIDIA Claymore 12.0
ECHO 4.  Ethereum Classic  (ETC)   Nanopool.org       AMD/NVIDIA Claymore 12.0
ECHO 5.  Ubiq              (UBQ)   ubiq.HODLPool      UBQHASH - Phoenix Miner 4.0b 
ECHO 6.  Musicoin          (MUS)   Coinmine.pl        AMD/NVIDIA Claymore 12.0
ECHO 7.  Musicoin          (MUS)   Miningpoolhub.com  AMD/NVIDIA Claymore 12.0
ECHO 8.  CLO               (CLO)   2Miners Pool       AMD/NVIDIA Claymore 12.0
ECHO 9.  Pirl             (PIRL)   cryptopools.info   0-150 MH/s    AMD/NVIDIA Claymore 12.0
ECHO 10. Pirl             (PIRL)   cryptopools.info   150-800 MH/s  AMD/NVIDIA Claymore 12.0
ECHO 11. Pirl             (PIRL)   cryptopools.info   800+ MH/s     AMD/NVIDIA Claymore 12.0
ECHO 12. Expanse           (EXP)   expmine.pro                      AMD/NVIDIA Claymore 12.0
ECHO 13. Ellaism          (ELLA)   ellaismpool        0-150 MH/s    AMD/NVIDIA Claymore 12.0
ECHO 14. Ellaism          (ELLA)   ellaismpool        150-800 MH/s  AMD/NVIDIA Claymore 12.0
ECHO 15. Ellaism          (ELLA)   ellaismpool        800+ MH/s     AMD/NVIDIA Claymore 12.0
ECHO 16. Ellaism          (ELLA)   minerpool.net      0-100 MH/s    AMD/NVIDIA Claymore 12.0
ECHO 17. Ellaism          (ELLA)   minerpool.net      100-800 MH/s  AMD/NVIDIA Claymore 12.0
ECHO 18. Ellaism          (ELLA)   minerpool.net      800+ MH/s     AMD/NVIDIA Claymore 12.0
ECHO =========================================================================
ECHO *                           PROGPOW1 ALGORITHM                          *
ECHO =========================================================================
ECHO 19.  BitcoinInterest (BCI)   Suprnova.cc         PROGPoW - AMD Miner
ECHO 20.  BitcoinInterest (BCI)   Suprnova.cc         PROGPoW CUDA 9.2 - nVidia Miner
ECHO 21.  BitcoinInterest (BCI)   Suprnova.cc         PROGPoW CUDA 10.0 - nVidia Miner
ECHO =========================================================================
ECHO *                           HEX ALGORITHM                               *
ECHO =========================================================================
ECHO 22.  XDNA            (XDNA)  BSOD                Z-Enemy 1.28 Cuda 10 - nVidia Miner
ECHO =========================================================================
ECHO *                           AEX ALGORITHM                               *
ECHO =========================================================================
ECHO 23.  AeriumX         (AEX)   mining.myce.world   Z-Enemy 1.28 Cuda 10 - nVidia Miner
ECHO =========================================================================
ECHO *                           TIME TRAVEL 10 ALGORITHM                    *
ECHO =========================================================================
ECHO 24.  Bitcore         (BTX)   yiimp.eu            Z-Enemy 1.28 Cuda 10 - nVidia Miner
ECHO =========================================================================
ECHO *                            PHI2 ALGORITHM                             *
ECHO =========================================================================
ECHO 25.  Luxcore         (LUX)  us.bsod              Z-Enemy 1.28 Cuda 10 - nVidia Miner
ECHO =========================================================================
ECHO *                            SKUNK ALGORITHM                            *
ECHO =========================================================================
ECHO 26.  C25             (C25)  us.bsod              Z-Enemy 1.28 Cuda 10 - nVidia Miner
ECHO =========================================================================
ECHO *                            SonoA ALGORITHM                            *
ECHO =========================================================================
ECHO 27.  Project SONO   (SONO)  mine.miningpatriot  Z-Enemy 1.28 Cuda 10 - NVIDIA Only
ECHO =========================================================================
ECHO *                            CNSABER ALGORITHM                          *
ECHO =========================================================================
ECHO 28.  Bittube          (TUBE) cryptoknight.cc     SRBMiner 1.7.5 - AMD Only
ECHO 29.  Bittube          (TUBE) cryptoknight.cc     CryptoDredge 0.15.1 CUDA 9.2 NVIDIA Only
ECHO 30.  Bittube          (TUBE) cryptoknight.cc     CryptoDredge 0.15.1 CUDA 10.0 NVIDIA Only
ECHO =========================================================================
ECHO *                           LYRA2Z ALGORITHM                            *
ECHO =========================================================================
ECHO 31.  Zcoin            (XZC)  Miningpoolhub.com   Wildrig 0.15.0.12
ECHO 32.  Zcoin            (XZC)  Miningpoolhub.com   CryptoDredge 0.15.1 CUDA 10.0 NVIDIA Only
ECHO =========================================================================
ECHO *                          NEOSCRYPT ALGORITHM                          *
ECHO =========================================================================
ECHO 33.
ECHO 34.  Feathercoin      (FTC)  F2Pool              CryptoDredge 0.15.1 NVIDIA Only
ECHO =========================================================================
ECHO *                       MYRIAD-GROESTLE ALGORITHM                       *
ECHO =========================================================================
ECHO 35.  Digibyte         (DGB)  Suprnova.cc         AMD Avermore 1.4.1
ECHO 36.  Digibyte         (DGB)  Suprnova.cc         NVIDIA Nevermore 0.2.3
ECHO =========================================================================
ECHO *                       CRYPTONIGHT V7 ALGORITHM                        *
ECHO =========================================================================
ECHO 37.  Monero           (XMR)  Nanopool.org        NVIDIA XMRig 2.5.2
ECHO 38.  Monero           (XMR)  Nanopool.org        Wildrig 0.15.0.12
ECHO 39.  
ECHO =========================================================================
ECHO *                         CRYPTONIGHT ALGORITHM                         *
ECHO =========================================================================
ECHO 40.  Electroneum      (ETN)  Easyhash.io         NVIDIA XMRig 2.5.2
ECHO 41.  Electroneum      (ETN)  Easyhash.io         Wildrig 0.15.0.12
ECHO 42.  Electroneum      (ETN)  Easyhash.io         
ECHO 43.  Sumokoin        (SUMO)  Easyhash.io         NVIDIA XMRig 2.5.2
ECHO 44.  Sumokoin        (SUMO)  Easyhash.io         Wildrig 0.15.0.12
ECHO 45.  Sumokoin        (SUMO)  Easyhash.io         
ECHO 46.  Karbowanec       (KRB)  Cryptoknight.cc     NVIDIA XMRig 2.5.2
ECHO 47.  Karbowanec       (KRB)  Cryptoknight.cc     Wildrig 0.15.0.12
ECHO 48.  Karbowanec       (KRB)  Cryptoknight.cc     
ECHO =========================================================================
ECHO *                         Tensority ALGORITHM                         *
ECHO =========================================================================
ECHO 49.  Bytom            (BTM)  F2Pool              NBMiner 12.3 NVIDIA Only
ECHO 50.  Bytom/Ethereum   (ETH)  F2Pool / Ethermine  NBMiner 12.3 NVIDIA Only
ECHO =========================================================================
ECHO *                            X16R ALGORITHM                             *
ECHO =========================================================================
ECHO 51.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA T-Rex 0.8.9 CUDA 9.1
ECHO 52.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA T-Rex 0.8.9 CUDA 10.0
ECHO 53.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA Enemy 1.28 CUDA 9.2
ECHO 54.  Ravencoin        (RVN)  Ravenminer.com      NVIDIA Enemy 1.28 CUDA 10.0
ECHO 55.  Ravencoin        (RVN)  Ravenminer.com      Wildrig 0.15.0.12
ECHO 56.  
ECHO =========================================================================
ECHO *                          LYRA2REV2 ALGORITHM                          *
ECHO =========================================================================
ECHO 57.  Vertcoin         (VTC)  Miningpoolhub.com   AMD LyclMiner 0.2.0 AMD Only
ECHO 58.  Vertcoin         (VTC)  Miningpoolhub.com   CryptoDredge 0.15.1 NVIDIA Only
ECHO =========================================================================
ECHO *                          LYRA2REV3 ALGORITHM (1st Feb 2019)           *
ECHO =========================================================================
ECHO 59.  Vertcoin         (VTC)  Miningpoolhub.com   AMD LyclMiner 0.2.0 AMD Only
ECHO 60.  Vertcoin         (VTC)  Miningpoolhub.com   CryptoDredge 0.15.1 NVIDIA Only
ECHO =========================================================================
ECHO *                           LYRA2Z ALGORITHM                            *
ECHO =========================================================================
ECHO 61.  MonaCoin        (MONA)  Miningpoolhub.com   AMD LyclMiner 0.2.0 AMD Only
ECHO 62.  MonaCoin        (MONA)  Miningpoolhub.com   CryptoDredge 0.15.1 NVIDIA Only
ECHO =========================================================================
ECHO *                           Equihash 210/9 ALGORITHM                    *
ECHO =========================================================================
ECHO 63.  AION            (AION)  AIONPOOL.TECH       GMiner 1.14 1-2GPU - NVIDIA Only
ECHO 64.  AION            (AION)  AIONPOOL.TECH       GMiner 1.14 3-8GPU - NVIDIA Only
ECHO 65.  AION            (AION)  AIONPOOL.TECH       lolMiner v0.6 1-2GPU - AMD Only
ECHO 66.  AION            (AION)  AIONPOOL.TECH       lolMiner v0.6 3-8GPU - AMD Only
ECHO =========================================================================
ECHO *                           Veil x16RT ALGORITHM                        *
ECHO =========================================================================
ECHO 67.  VEIL            (VEIL)  Pending       Pending
ECHO 68.  VEIL            (VEIL)  Pending       Pending
ECHO =========================================================================
ECHO *                           BEAM Equihash MW ALGORITHM                  *
ECHO =========================================================================
ECHO 69.  BEAM            (BEAM)  LEAFPOOL            lolMiner 0.7 alpha 1 - AMD Only
ECHO 70.  BEAM            (BEAM)  LEAFPOOL            GMiner 1.18 - NVIDIA only
ECHO =========================================================================
ECHO *                     Ethereum Gangnam Testnet ETH-PROGPOW ALGORITHM    *
ECHO =========================================================================
ECHO 71.  ETH TEST        (ETH)  testnet.progpool.pro PROGPOW Miner AMD 1.0.2
ECHO 72.  ETH TEST        (ETH)  testnet.progpool.pro PROGPOW Miner NVIDIA 1.0.2
ECHO 73.  ETH TEST        (ETH)  gangnam.wattpool.net PROGPOW Miner AMD 1.0.2
ECHO 74.  ETH TEST        (ETH)  gangnam.wattpool.net PROGPOW Miner NVIDIA 1.0.2
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
IF %M%==8 GOTO CLO1
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
IF %M%==19 GOTO PROG1
IF %M%==20 GOTO PROG2
IF %M%==21 GOTO PROG3
IF %M%==22 GOTO XDNA1
IF %M%==23 GOTO AEX1
IF %M%==24 GOTO BTX1
IF %M%==25 GOTO LUX1
IF %M%==26 GOTO C251
IF %M%==27 GOTO SONO1
IF %M%==28 GOTO BTUBE1
IF %M%==29 GOTO BTUBE2
IF %M%==30 GOTO BTUBE3
IF %M%==31 GOTO XZC1
IF %M%==32 GOTO XZC2
IF %M%==33 GOTO FTC1
IF %M%==34 GOTO FTC2
IF %M%==35 GOTO DGB1
IF %M%==36 GOTO DGB2
IF %M%==37 GOTO XMR1
IF %M%==38 GOTO XMR2
IF %M%==39 GOTO XMR3
IF %M%==40 GOTO ETN1
IF %M%==41 GOTO ETN2
IF %M%==42 GOTO ETN3
IF %M%==43 GOTO SUMO1
IF %M%==44 GOTO SUMO2
IF %M%==45 GOTO SUMO3
IF %M%==46 GOTO KRB1
IF %M%==47 GOTO KRB2
IF %M%==48 GOTO KRB3
IF %M%==49 GOTO BTM1
IF %M%==50 GOTO BTM2
IF %M%==51 GOTO RVN1
IF %M%==52 GOTO RVN2
IF %M%==53 GOTO RVN3
IF %M%==54 GOTO RVN4
IF %M%==55 GOTO RVN5
IF %M%==56 GOTO RVN6
IF %M%==57 GOTO VTC1
IF %M%==58 GOTO VTC2
IF %M%==59 GOTO VTC3
IF %M%==60 GOTO VTC4
IF %M%==61 GOTO MONA1
IF %M%==62 GOTO MONA2
IF %M%==63 GOTO AION1
IF %M%==64 GOTO AION2
IF %M%==65 GOTO AION3
IF %M%==66 GOTO AION4
IF %M%==67 GOTO VEIL1
IF %M%==68 GOTO VEIL2
IF %M%==69 GOTO BEAM1
IF %M%==70 GOTO BEAM2
IF %M%==71 GOTO PROGETH1
IF %M%==72 GOTO PROGETH2
IF %M%==73 GOTO PROGETH3
IF %M%==74 GOTO PROGETH4
IF %M%>75 GOTO EOF

::
:: Ethereum miners
::
:ETH1
ECHO AMD and NVIDIA Claymore 12.0 - Eth Only Ethermine.org
Miners\Claymore-v12.0\EthDcrMiner64 -epool us1.ethermine.org:14444 -ewal %ETH%.%MINER_NAME% -epsw %WORKER_PASSWORD% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ETH2
ECHO AMD and NVIDIA Claymore 12.0 - Eth Only Nanopool.org
Miners\Claymore-v12.0\EthDcrMiner64 -epool eth-us-east1.nanopool.org:9999 -ewal %ETH%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ethereum Classic miners
::
:ETC1
ECHO AMD and NVIDIA Claymore 12.0 - Etc (ethereum classic) etc.ethermine.org
Miners\Claymore-v12.0\EthDcrMiner64 -epool us1-etc.ethermine.org:4444 -ewal %ETC%.%MINER_NAME% -epsw %WORKER_PASSWORD% -mode 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ETC2
ECHO AMD and NVIDIA Claymore 12.0 - Etc (ethereum classic) to Nanopool
Miners\Claymore-v12.0\EthDcrMiner64 -epool etc-us-east1.nanopool.org:19999 -ewal %ETC%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ubiq Miners
:: NOTE: if you have 1 GPU and it shows two, then place -di 0 or 1 to show a single GPU
:UBQ1
ECHO Phoenix Miner 4.0b - Ubiq to Hodl Pool Only
Miners\PhoenixMiner_4.0b_Windows\PhoenixMiner.exe -di 0 -pool stratum+tcp://ubiq.hodlpool.com:8009  -wal %UBQ% -worker %MINER_NAME%  -coin ubq
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Musicoin Miners
::
:MUS1
ECHO AMD and NVIDIA Claymore 12.0 - Musicoin to Coinmine.pl
Miners\Claymore-v12.0\EthDcrMiner64 -epool music.coinmine.pl:2020 -ewal %MUS%.%MINER_NAME% -dpsw x -mode 1 -allcoins 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:MUS2
ECHO AMD and NVIDIA Claymore 12.0 - Musicoin to miningpoolhub Pool Only
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Pirl Miners
::
:PIRL1
ECHO AMD and NVIDIA Claymore 12.0 - Pirl to HPPCG Pool
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://us-nj-01.pools.hppcg.com:8005 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PIRL2
ECHO AMD and NVIDIA Claymore 12.0 - Pirl 0-150 MH/s Cryptopools.info
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://pirl.cryptopools.info:8002 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PIRL3
ECHO AMD and NVIDIA Claymore 12.0 - Pirl 150-800 MH/s Cryptopools.info
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://pirl.cryptopools.info:8004 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PIRL4
ECHO AMD and NVIDIA Claymore 12.0 - Pirl 800+ MH/s Cryptopools.info
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://pirl.cryptopools.info:8008 -ewal %PIRL% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1 -eworker %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Expanse Miner
::
:EXP1
ECHO AMD and NVIDIA Claymore 12.0 - Expanse to expmine.pro
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://us.expmine.pro:9009 -ewal %EXP% -epsw %WORKER_PASSWORD% -allcoins 1 -allpools 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ellaism Miners
::
:ELLA1
ECHO AMD and NVIDIA Claymore 12.0 - Ella 0-150 MH/s ellaismpool
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://ellaismpool.com:8008 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA2
ECHO AMD and NVIDIA Claymore 12.0 - Ella 150-800 MH/s ellaismpool
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://ellaismpool.com:8004 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA3
ECHO AMD and NVIDIA Claymore 12.0 - Ella 800+ MH/s ellaismpool
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://ellaismpool.com:8009 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA4
ECHO AMD and NVIDIA Claymore 12.0 - Ella 0-100 MH/s minerpool.net
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://lb.geo.ellapool.eu:8002 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA5
ECHO AMD and NVIDIA Claymore 12.0 - Ella 100-800 MH/s minerpool.net
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://lb.geo.ellapool.eu:8004 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:ELLA6
ECHO AMD and NVIDIA Claymore 12.0 - Ella 800+ MH/s minerpool.net
Miners\Claymore-v12.0\EthDcrMiner64 -epool stratum+tcp://lb.geo.ellapool.eu:8009 -ewal %ELLA% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: PROGPoW Miners
::
:PROG1
ECHO PROGPOW 0.16 AMD - Suprnova.cc BitcoinInterest
Miners\progpowminer-amd-windows-0.16\progpowminer-amd -G --opencl-platform 1 -P stratum+tcp://bitsbetrippin.RX590:x@bci.suprnova.cc:9166 
IF %ERRORLEVEL% NEQ 0 GOTO exit
:PROG2
ECHO PROGPOW 0.16 NVIDIA CUDA9.2 - Suprnova.cc BitcoinInterest
Miners\progpowminer-cuda-windows-0.16\Cuda9.2\progpowminer-cuda -U -P stratum+tcp://bitsbetrippin.titanv:x@bci.suprnova.cc:9166 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PROG3
ECHO PROGPOW 0.16 NVIDIA CUDA10.0 - Suprnova.cc BitcoinInterest
Miners\progpowminer-cuda-windows-0.16\Cuda10\progpowminer-cuda -U -P stratum+tcp://bitsbetrippin.titanv:x@bci.suprnova.cc:9166 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: XDNA Miners
::
:XDNA1
ECHO Z-Enemy 1.28 - XDNA to BSOD
Miners\z-enemy.1-28-cuda10.0\z-enemy -a hex -o stratum+tcp://eu.bsod.pw:2320 -u %HEX% -p d=4 -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: AeriumX Miners
::
:AEX1
ECHO Z-Enemy 1.28 - AeriumX to mining.myce.world
Miners\z-enemy.1-28-cuda10.0\z-enemy -a aeriumx -o stratum+tcp://mining.myce.world:3033 -u %AEX% -p x
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Bitcore Miners
::
:BTX1
ECHO Z-Enemy 1.28 - Bitcore to yiimp.eu
Miners\z-enemy.1-28-cuda10.0\z-enemy -a bitcore -o stratum+tcp://yiimp.eu:3566 -u %BTX% -p x -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Luxcore Miners
::
:LUX1
ECHO Z-Enemy 1.28 - Luxcore to us.bsod
Miners\z-enemy.1-28-cuda10.0\z-enemy -a phi2 -o stratum+tcp://us.bsod.pw:6667 -u %LUX% -p x -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: C25 Miners
::
:C251
ECHO Z-Enemy 1.28 - C25 to us.bsod
Miners\z-enemy.1-28-cuda10.0\z-enemy -a skunk -o stratum+tcp://us.bsod.pw:2504 -u %C25% -p x -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: SONO Miners
::
:SONO1
ECHO Z-Enemy 1.28 - SONO to mine.miningpatriot
Miners\z-enemy.1-28-cuda10.0\z-enemy -a sonoa -o stratum+tcp://mine.miningpatriot.com:8439 -u %SONO% -p x
IF %ERRORLEVEL% NEQ 0 GOTO exit
::
:: Bittube Miners
::
:BTUBE1
ECHO SRBMiner - BITTUBE to Cryptoknight.cc AMD Only
Miners\SRBMiner-CN-V1-7-5\start-BITTUBE
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:BTUBE2
ECHO CryptoDredge 0.15.1 to cryptoknight.cc - CUDA 9.2 nVidia
Miners\CryptoDredge_0.15.1_win_x64_cuda_9.2\CryptoDredge -a CryptoNightSaber -o stratum+tcp://tube.ingest.cryptoknight.cc:5632 -u %BTUBE% -p %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:BTUBE3
ECHO CryptoDredge 0.15.1 to cryptoknight.cc - CUDA 10.0 nVidia
Miners\CryptoDredge_0.15.1_win_x64_cuda_10.0\CryptoDredge -a CryptoNightSaber -o stratum+tcp://tube.ingest.cryptoknight.cc:5632 -u %BTUBE% -p %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Zcoin Miners
::
:XZC1
ECHO Wildrig 0.15.0.12 - AMD Only - Zcoin to Miningpoolhub.com
Miners\wildrig-multi-windows-0.15.1.3-beta\wildrig.exe --algo mtp --opencl-threads 1 --opencl-launch 16x0 --url stratum+tcp://xzc.2miners.com:8080 --user %XZC% --pass x
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:XZC2
ECHO CryptoDredge 0.15.1 - Zcoin to Miningpoolhub.com Nvidia Only 
Miners\CryptoDredge_0.15.1_win_x64_cuda_10.0\CryptoDredge -a lyra2z -o stratum+tcp://us-east.lyra2z-hub.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I %I%
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
ECHO CryptoDredge 0.15.1 to - FTC to P2Pool FTC - CUDA 10.0 nVidia
Miners\CryptoDredge_0.15.1_win_x64_cuda_10.0\CryptoDredge -a neoscrypt -o stratum+tcp://46.4.0.101:19327 -u %FTC% -p %WORKER_PASSWORD% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Digibyte Miners
::
:DGB1
ECHO AMD Avermore 1.4.1 GROESTL - Digibyte to Suprnova.cc
Miners\avermore-windows-1.4.1\sgminer -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I %I% -g 4 -w 128 -k myriadcoin-groestl --no-submit-stale
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
:: Bytom Miners
::
:BTM1
ECHO NBMiner 12.3 - BTM NVIDIA Only
Miners\NBMiner_12.3_Win\nbminer -a tensority -o stratum+tcp://btm.f2pool.com:9221 -u %BTM% -log
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:BTM2
ECHO NBMiner 12.3 - BTM/ETH NVIDIA Only
Miners\NBMiner_12.3_Win\nbminer -a tensority_ethash -o stratum+tcp://btm.f2pool.com:9221 -u %BTM% -do ethproxy+tcp://us1.ethermine.org:14444 -du %ETH%.%MINER_NAME% -log
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Ravencoin Miners
::
:RVN1
ECHO T-Rex 0.8.9 CUDA 9.1 NVIDIA Only
Miners\t-rex-0.9.1-win-cuda9.1\t-rex -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:RVN2
ECHO T-Rex 0.8.9 CUDA 10.0 NVIDIA Only
Miners\t-rex-0.9.1-win-cuda10.0\t-rex -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:RVN3
ECHO Z-Enemy 1.28 CUDA 9.2 - Nvidia Only - RavenCoin to Ravenminer.com
Miners\z-enemy.1-28-cuda9.2\z-enemy -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:RVN4
ECHO Z-Enemy 1.28 CUDA 10.0 - Nvidia Only - RavenCoin to Ravenminer.com
Miners\z-enemy.1-28-cuda10.0\z-enemy -a x16r -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
:RVN5
ECHO Wildrig Multi 0.14.0b - AMD Only - RavenCoin to Ravenminer.com
Miners\wildrig-multi-windows-0.15.1.3-beta\wildrig -algo x16r -url=us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% 
PAUSE
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: Vertcoin Miner
::
:VTC1
ECHO AMD Avermore 1.4.1 - Vertcoin to Miningpoolhub Lyra2REv2
Miners\avermore-windows-1.4.1\sgminer -o stratum+tcp://hub.miningpoolhub.com:20507 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -k lyra2rev2 --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:VTC2
ECHO CryptoDredge 0.15.1 - Nvidia Only - Vertcoin to Miningpoolhub Lyra2REv2
Miners\CryptoDredge_0.15.1_win_x64_cuda_10.0\CryptoDredge -a Lyra2REv2 -o stratum+tcp://hub.miningpoolhub.com:20507 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:VTC3
ECHO AMD LyclMiner 0.2.0 - Vertcoin to Miningpoolhub Lyra2REv3
Miners\avermore-windows-1.4.1 sgminer -o stratum+tcp://vtc.suprnova.cc:5678 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -k lyra2rev2 --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:VTC4
ECHO CryptoDredge 0.15.1 - Nvidia Only - Vertcoin to Miningpoolhub Lyra2REv3
Miners\CryptoDredge_0.15.1_win_x64_cuda_10.0\CryptoDredge -a Lyra2REv3 -o stratum+tcp://hub.miningpoolhub.com:20507 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: MonaCoin Miners
::
:MONA1
ECHO AMD Avermore 1.4.1 - MonaCoin to miningpoolhub.com
Miners\avermore-windows-1.4.1\sgminer -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p x -k lyra2z --no-submit-stale
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:MONA2
ECHO CryptoDredge 0.15.1 - Nvidia Only - Monacoin to Miningpoolhub
Miners\CryptoDredge_0.15.1_win_x64_cuda_10.0\CryptoDredge -a Lyra2z -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: AION Miners
::
:AION1
ECHO GMiner 1.14 1-2GPU -  NVIDIA Only
Miners\gminer_1_14_windows64\miner.exe --algo 210_9 --pers AION0PoW --server cluster.aionpool.tech --port 2222 --user %AION% --pass %WORKER_PASSWORD% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:AION2
ECHO GMiner 1.14 3-8GPU -  NVIDIA Only
Miners\gminer_1_14_windows64\miner.exe --algo 210_9 --pers AION0PoW --server cluster.aionpool.tech --port 3333 --user %AION% --pass %WORKER_PASSWORD% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:AION3
ECHO lolMiner 0.06 1-2GPU -  AMD OnlypanAN
Miners\lolMiner_v06_Win64\lolMiner lolMiner.exe --coin AION --pool cluster.aionpool.tech --port 2222 --user %AION% --pass %WORKER_PASSWORD% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:AION4
ECHO lolMiner 0.06 3-8GPU -  AMD Only
Miners\lolMiner_v06_Win64\lolMiner lolMiner.exe --coin AION --pool cluster.aionpool.tech --port 3333 --user %AION% --pass %WORKER_PASSWORD% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: CLO Miners
::
:CLO1
ECHO AMD and NVIDIA Claymore 12.0 - CLO to 2Miners
Miners\Claymore-v12.0\EthDcrMiner64 -epool us-clo.2miners.com:3030 -ewal %CLO%.%MINER_NAME% -epsw %WORKER_PASSWORD% -allcoins etc -allpools 0 -eworker %MINER_NAME% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: VIEL Miners
::
:VIEL1
ECHO AMD and NVIDIA Claymore 12.0 - CLO to 2Miners
Miners\wildrig-multi-windows-0.15.1.3-beta\wildrig -algo x16rt -url=us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME% 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:VIEL2
ECHO T-Rex 0.8.9 CUDA 10.0 NVIDIA Only
Miners\t-rex-0.9.1-win-cuda10.0\t-rex -a x16rt -o stratum+tcp://us.ravenminer.com:4567 -u %RVN% -p %MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: BEAM Miners
:: Use Port 3333 for single GPU, use port 4444 for mining rigs, use port 5555 for "big ass mining rigs"
:BEAM1
ECHO lolMiner 0.7 alpha 1 - BEAM to Leafpool
Miners\lolMiner_v07_alpha_1_Win64\lolMiner --coin BEAM --pool beam.sparkpool.com --port 2222 --ssl 1 --user %BEAM%.%MINER_NAME%
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:BEAM2
ECHO GMiner 1.18 - BEAM to Leafpool
Miners\gminer_1_18_windows64\miner.exe --algo 150_5 --server beam.sparkpool.com --port 2222 --ssl 1 --user %BEAM%.%MINER_NAME%

IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
::
:: PROGPOWETH Miners
::
:PROGETH1
ECHO PROGMiner 1.0.2 AMD - PROGETH to PROGPOOL.PRO
Miners\progminer-1.0.2-amd-windows\progminer.exe -P stratum1+tcp://0x1FD15054675c913b5B7A21b0d7338fff9FAFB8eE.TitanV@testnet.progpool.pro:8008
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PROGETH2
ECHO PROGMiner 1.0.2 NVIDIA - PROGETH to PROGPOOL.PRO
Miners\progminer-1.0.2-cuda10.0-windows\progminer.exe -P stratum1+tcp://0x1FD15054675c913b5B7A21b0d7338fff9FAFB8eE.TitanV@testnet.progpool.pro:8008 
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PROGETH3
ECHO PROGMiner 1.0.2 AMD - PROGETH to WATTPOOL.NET
Miners\progminer-1.0.2-amd-windows\progminer.exe -P stratum1+tcp://0x1FD15054675c913b5B7A21b0d7338fff9FAFB8eE.TitanV@gangnam.wattpool.net:8008
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE
:PROGETH4
ECHO AMD and NVIDIA Claymore 12.0 - PROGETH to WATTPOOL.NET
Miners\progminer-1.0.2-cuda10.0-windows\progminer.exe -P stratum1+tcp://0x1FD15054675c913b5B7A21b0d7338fff9FAFB8eE.TitanV@gangnam.wattpool.net:8008
IF %ERRORLEVEL% NEQ 0 GOTO exit
PAUSE




