@echo off
setlocal EnableDelayedExpansion 
rem **********************************************************************
rem *         BBT Multi-Miner Easy Batch File  v6.0 by BBT Carter        *
rem **********************************************************************
rem * BEST VIEWED IN FULL SCREEN 1920x1080
rem **********************************************************************

CALL my_info.bat

SET ETH_WALLET_ADDRESS=%ETH%
SET ETC_WALLET_ADDRESS=%ETC%
SET XMR_WALLET_ADDRESS=%XMR%
SET SIA_WALLET_ADDRESS=%SIA%
SET ZCASH_WALLET_ADDRESS=%ZCASH%
SET PASCAL_WALLET_ADDRESS=%PASCAL%
SET HUSH_WALLET_ADDRESS=%HUSH%
SET LBRY_WALLET_ADDRESS=%LBRY%
SET DECRED_WALLET_ADDRESS=%DECRED%
SET DBIX_WALLET_ADDRESS=%DBIX%
SET UBIQ_WALLET_ADDRESS=%UBIQ%
SET EXP_WALLET_ADDRESS=%EXP%
SET CHC_WALLET_ADDRESS=%CHC%
SET DIGI_WALLET_ADDRESS=%DIGI%
SET FTC_WALLET_ADDRESS=%FTC%
SET MUS_WALLET_ADDRESS=%MUS%
SET ZCL_WALLET_ADDRESS=%ZCL%
SET ZEN_WALLET_ADDRESS=%ZEN%
SET LTC_WALLET_ADDRESS=%LTC%
SET BTC_WALLET_ADDRESS=%BTC%
SET BTG_WALLET_ADDRESS=%BTG% 
SET PIRL_WALLET_ADDRESS=%PIRL%
SET ETN_WALLET_ADDRESS=%ENT%
SET VTC_WALLET_ADDRESS=%VTC%
SET KMD_WALLET_ADDRESS=%KMD%
SET ELLA_WALLET_ADDRESS=%ELLA%
SET SUMO_WALLET_ADDRESS=%SUMO%
SET KRB_WALLET_ADDRESS=%KRB%
SET MONA_WALLET_ADDRESS=%MONA%
SET BWK_WALLET_ADDRESS=%BWK%
SET RVN_WALLET_ADDRESS=%RVN%
SET PGN_WALLET_ADDRESS=%PGN%
SET BTCP1_WALLET_ADDRESS=%BTCP1%
SET BTCP2_WALLET_ADDRESS=%BTCP2%

:: *** Miner login for pools like suprnova.cc
:: *** dont get excited, our primary mining weblogin is not bitsbetrippin, used as example
:: *** MUST UPDATE JSON FILE FOR NVIDIA XMR FOR USER INFO

SET MINER_WEBLOGIN=%MINER-WEBLOGIN%
SET WORKER_PASSWORD=%WORKER-PASSWORD%
SET MINER_NAME=%MINER-NAME%
SET EMAIL_ADDRESS=%EMAIL-ADDRESS%

::Set Intensity Globally
SET I=20
::Set Thread Concurrency Globally
SET TC=1024
::GPU Platform (AMD) Options 0 or 1
SET Platform=1

:: Environmental Variables
setx GPU_FORCE_64BIT_PTR 0 >nul 2>&1
setx GPU_MAX_HEAP_SIZE 100 >nul 2>&1
setx GPU_USE_SYNC_OBJECTS 1 >nul 2>&1
setx GPU_MAX_ALLOC_PERCENT 100 >nul 2>&1
setx GPU_SINGLE_ALLOC_PERCENT 100 >nul 2>&1

SET miner=%1
IF NOT "%miner%"=="" (
    SET /A M=%miner%
    goto MinerSwitch
)
ECHO ====================================================
ECHO *                ETHEREUM (ETH) Algorithm:Ethash   *
ECHO ====================================================
ECHO 1.  AMD and NVIDIA Claymore 11.6 - Eth Only Ethermine.org
ECHO 2.  AMD and NVIDIA Claymore 11.6 - Eth Nanopool Only
ECHO ====================================================
ECHO *        ETHEREUM Classic (ETC) Algorithm:Dagger   *
ECHO ====================================================
ECHO 3.  AMD and NVIDIA Claymore 11.6 - Etc etc.ethermine.org
ECHO 4.  AMD and NVIDIA Claymore 11.6 - Etc Nanopool Only
ECHO ====================================================
ECHO *                    UBIQ (UBQ) Algorithm:Dagger   *
ECHO ====================================================
ECHO 5.  AMD and NVIDIA Claymore 11.6 - Ubiq to Hodl Pool
ECHO ====================================================
ECHO *                Musicoin (MUS) Algorithm:Ethash   *
ECHO ====================================================
ECHO 6.  AMD and NVIDIA Claymore 11.6 - Musicoin to pool.io
ECHO 7.  AMD and NVIDIA Claymore 11.6 - Musicoin to miningpoolhub Only
ECHO ====================================================
ECHO *                   PIRL (PIRL) Algorithm:Dagger   *
ECHO ====================================================
ECHO 8.  AMD and NVIDIA Claymore 11.6 - Pirl pools.hppcg - US based Pool
ECHO 9.  AMD and NVIDIA Claymore 11.6 - Pirl LESS THAN 100 MH/s Only cryptopools.info
ECHO 10. AMD and NVIDIA Claymore 11.6 - Pirl 100 MH/s to 800 MH/s Only cryptopools.info
ECHO 11. AMD and NVIDIA Claymore 11.6 - Pirl MORE THAN 800 MH/s Only cryptopools.info
ECHO ====================================================
ECHO *                 Expanse (EXP) Algorithm:Dagger   *
ECHO ====================================================
ECHO 12.  AMD and NVIDIA Claymore 11.6 - Expanse to expmine.pro pool
ECHO ====================================================
ECHO *                Ellaism (ELLA) Algorithm:Ethash   *
ECHO ====================================================
ECHO 13.  AMD and NVIDIA Claymore 11.6 - Ella LESS THAN 180 MH/s ellaismpool US Based
ECHO 14.  AMD and NVIDIA Claymore 11.6 - Ella 100 MH/s to 800 MH/s ellaismpool US Based
ECHO 15.  AMD and NVIDIA Claymore 11.6 - Ella MORE THAN 800 MH/s ellaismpool US Based
ECHO 16.  AMD and NVIDIA Claymore 11.6 - Ella LESS THAN 100 MH/s Only minerpool.net EU Based
ECHO 17.  AMD and NVIDIA Claymore 11.6 - Ella 100 MH/s to 800 MH/s Only minerpool.net EU Based
ECHO 18.  AMD and NVIDIA Claymore 11.6 - Ella MORE THAN 800 MH/s Only minerpool.net EU Based
ECHO ====================================================
ECHO *                 ZCASH (ZEC) Algorithm:Equihash   *
ECHO ====================================================
ECHO 19.  AMD ZCash Claymore 12.6 - Zcash to Nanopool
ECHO 20.  NVIDIA DSTM 0.6 Zcash Miner - Zcash to Nanopool
ECHO ====================================================
ECHO *               Komodo (KMD) Algorithm:Equihash    *
ECHO ====================================================
ECHO 21.  AMD Claymore 12.6 - Komodo to Suprnova.cc
ECHO 22.  NVIDIA DSTM 0.6 ZMiner - Komodo to Suprnova.cc
ECHO ====================================================
ECHO *     Bitcoin Private (BTCP) Algorithm:Equihash    *
ECHO ====================================================
ECHO 23.  AMD Claymore 12.6 - Bitcoin Private to btcprivate.org
ECHO 24.  NVIDIA DSTM 0.6 ZMiner - Bitcoin Private to btcprivate.org
ECHO ====================================================
ECHO *             Zclassic (ZCL) Algorithm:Equihash    *
ECHO ====================================================
ECHO 25.  AMD Claymore 12.6 - Zclassic to Miningpoolhub
ECHO 26.  NVIDIA DSTM 0.6 ZMiner - Zclassic to Miningpoolhub
ECHO ====================================================
ECHO *              ZENCash (ZEN) Algorithm:Equihash    *
ECHO ====================================================
ECHO 27.  AMD Claymore 12.6 - ZENCash to Supernova.cc
ECHO 28.  NVIDIA DSTM ZMiner 0.6 ZENCash to Supernova.cc
ECHO 29.  AMD Claymore 12.6 - ZENCash to zhash.pro
ECHO 30.  NVIDIA DSTM 0.6 ZMiner - ZENCash zhash.pro
ECHO ====================================================
ECHO *                  Zcoin (XZC) Algorithm:Lyra2z    *
ECHO ====================================================
ECHO 31.  Nevermore 0.2.2 - Nvidia Only - Zcoin to Miningpoolhub
ECHO 32.  Brians SGMinger 0.4.0 - AMD Only - Zcoin to Miningpoolhub
ECHO ====================================================
ECHO *          Feathercoin (FTC) Algorithm:Neoscrypt   *
ECHO ====================================================
ECHO 33.  Nevermore 0.2.2 - Nvidia Only - FTC to F2Pool FTC
ECHO 34.  AMD NSGMiner 0.9.2 Feathercoin Miner - FTC to P2Pool FTC
ECHO ====================================================
ECHO *          Digibyte (DGB)    Algorithm:Groestle    *
ECHO ====================================================
ECHO 35.  Brians SGMinger AMD 0.4.0 GROESTL - Digibyte to Suprnova.cc
ECHO 36.  Nevermore 0.2.2 - Nvidia Only - Digibyte to Suprnova.cc
ECHO ====================================================
ECHO *               Monero (XMR) Algorithm:Cryptonite  *
ECHO ====================================================
ECHO 37.  XMRig 2.5.2 NVIDIA - XMR to Nanopool- XMR to Nanopool
ECHO 38.  XMRig 2.5.2 AMD - XMR to Nanopool - XMR to Nanopool
ECHO 39.  CAST XMR Vega Miner 0.9.2 - XMR to Nanopool
ECHO ====================================================
ECHO *          Electroneum (ETN) Algorithm:Cryptonite  *
ECHO ====================================================
ECHO 40.  XMRig 2.5.2 NVIDIA - Electroneum to easyhash.io
ECHO 41.  XMRig 2.5.2 AMD - Electroneum to easyhash.io
ECHO 42.  CAST XMR Vega Miner 0.9.2 - XMR to Electroneum to easyhash.io 
ECHO ====================================================
ECHO *            Sumokoin (SUMO) Algorithm:Cryptonite  *
ECHO ====================================================
ECHO 43.  XMRig 2.5.2 NVIDIA - Sumokoin to easyhash.io
ECHO 44.  XMRig 2.5.2 AMD - Sumokoin to easyhash.io
ECHO 45.  CAST XMR Vega Miner 0.9.2 - XMR to Sumokoin to easyhash.io 
ECHO ====================================================
ECHO *           Karbowanec (KRB) Algorithm:Cryptonite  *
ECHO ====================================================
ECHO 46.  XMRig 2.5.2 NVIDIA - Karbowanec to easyhash.io
ECHO 47.  XMRig 2.5.2 AMD - Karbowanec to easyhash.io
ECHO 48.  CAST XMR Vega Miner 0.9.2 - XMR to Karbowanec to easyhash.io
ECHO ====================================================
ECHO *             Bulwark (BWK) Algorithm:NIST5        *
ECHO ====================================================
ECHO 49.  Brians SGMinger AMD 0.4.0 Bulkwark to bsod.pw 
ECHO 50.  Nevermore 0.2.2 - Nvidia Only - Bulkwark to bsod.pw 
ECHO ====================================================
ECHO *             Ravencoin (RVN) Algorithm:x16r       *
ECHO ====================================================
ECHO 51.  Brians SGMinger AMD 0.4.0 - RavenCoin to Threeyed
ECHO 52.  Nevermore 0.2.2 - Nvidia Only - RavenCoin to Threeyed
ECHO 53.  Enemy 1.3.0 - Nvidia Only - RavenCoin to Threeyed
ECHO 54.  Suprminer 1.6.0 - Nvidia Only - RavenCoin to Threeyed
ECHO ====================================================
ECHO *             Pigeoncoin (PGN) Algorithm:x16s       *
ECHO ====================================================
ECHO 55.  Brians SGMinger AMD 0.4.0 - Pigeoncoin to Blockcruncher
ECHO 56.  Nevermore 0.2.2 - Nvidia Only - Pigeoncoin to Blockcruncher
ECHO ====================================================
ECHO *                    Vertcoin (VTC)                *
ECHO ====================================================
ECHO 57.  Mkxminer 3.1.0 - AMD Only - Vertcoin to Miningpoolhub
ECHO 58.  Nevermore 0.2.2 - Nvidia Only - Vertcoin to Miningpoolhub
ECHO ====================================================
ECHO *            MonaCoin (MONA) Algorithm:Lyra2z      *
ECHO ====================================================
ECHO 59.  Mkxminer 3.1.0 - AMD Only - Monacoin to Miningpoolhub
ECHO 60.  Nevermore 0.2.2 - Nvidia Only - Monacoin to Miningpoolhub   
ECHO ****************************************************
ECHO 99 - EXIT
ECHO.

:MinerSwitch
:: Get input from user
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
if %ERRORLEVEL% NEQ 0 goto EOF

:: Is choice a number?
SET "var="&for /f "delims=0123456789" %%i in ("%M%") do set var=%%i
if defined var goto EOF

IF %M%==1 GOTO ethereum1
IF %M%==2 GOTO ethereum2
IF %M%==3 GOTO ethereumc1
IF %M%==4 GOTO ethereumc2
IF %M%==5 GOTO ubiq1
IF %M%==6 GOTO mus1
IF %M%==7 GOTO mus2
IF %M%==8 GOTO pirl1
IF %M%==9 GOTO pirl2
IF %M%==10 GOTO pirl3
IF %M%==11 GOTO pirl4
IF %M%==12 GOTO exp1
IF %M%==13 GOTO ella1
IF %M%==14 GOTO ella2
IF %M%==15 GOTO ella3
IF %M%==16 GOTO ella4
IF %M%==17 GOTO ella5
IF %M%==18 GOTO ella6
IF %M%==19 GOTO zcash1
IF %M%==20 GOTO zcash2
IF %M%==21 GOTO komodo1
IF %M%==22 GOTO komodo2
IF %M%==23 GOTO btcp1
IF %M%==24 GOTO btcp2
IF %M%==25 GOTO zcl1
IF %M%==26 GOTO zcl2
IF %M%==27 GOTO zen1
IF %M%==28 GOTO zen2
IF %M%==29 GOTO zen3
IF %M%==30 GOTO zen4
IF %M%==31 GOTO zcoin1
IF %M%==32 GOTO zcoin2
IF %M%==33 GOTO ftc1
IF %M%==34 GOTO ftc2
IF %M%==35 GOTO dgb1
IF %M%==36 GOTO dgb2
IF %M%==37 GOTO monero1
IF %M%==38 GOTO monero2
IF %M%==39 GOTO monero3
IF %M%==40 GOTO etn1
IF %M%==41 GOTO etn2
IF %M%==42 GOTO etn3
IF %M%==43 GOTO sumo1
IF %M%==44 GOTO sumo2
IF %M%==45 GOTO sumo3
IF %M%==46 GOTO karb1
IF %M%==47 GOTO karb2
IF %M%==48 GOTO karb3
IF %M%==49 GOTO bulk1
IF %M%==50 GOTO bulk2
IF %M%==51 GOTO rvn1
IF %M%==52 GOTO rvn2
IF %M%==53 GOTO rvn3
IF %M%==54 GOTO rvn4
IF %M%==55 GOTO pgn1
IF %M%==56 GOTO pgn2
IF %M%==57 GOTO vtc1
IF %M%==58 GOTO vtc2
IF %M%==59 GOTO mona1
IF %M%==60 GOTO mona2
IF %M% GTR 61 GOTO EOF

::
:: Ethereum miners
::

:ethereum1
ECHO AMD and NVIDIA Claymore 11.6 - Eth Only Ethermine.org
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool us1.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum2
ECHO AMD and NVIDIA Claymore 11.6 - Eth Only Nanopool.org
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool eth-us-east1.nanopool.org:9999 -ewal %ETC_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ethereum Classic miners
::

:ethereumc1
ECHO AMD and NVIDIA Claymore 11.6 - Etc (ethereum classic) etc.ethermine.org
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool us1-etc.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD% -mode 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereumc2
ECHO AMD and NVIDIA Claymore 11.6 - Etc (ethereum classic) to Nanopool
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool etc-us-east1.nanopool.org:19999 -ewal %ETC_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ubiq Miners
::

:ubiq1
ECHO AMD and NVIDIA Claymore 11.6 - Ubiq to Hodl Pool Only
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBIQ_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -allpools 1 -allcoins 1 -mode 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Musiccoin Miners
::

:mus1
ECHO AMD and NVIDIA Claymore 11.6 - Musiccoin to pool.io
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool us.gmc.epool.io:8008 -ewal %MUS_WALLET_ADDRESS% -eworker %MINER_NAME% -epsw %WORKER_PASSWORD% -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mus2
ECHO AMD and NVIDIA Claymore 11.6 - Musiccoin to miningpoolhub Pool Only
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Pirl Miners
::

:pirl1
ECHO AMD and NVIDIA Claymore 11.6 - Pirl to HPPCG Pool
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://us-nj-01.pools.hppcg.com:8005 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pirl2
ECHO AMD and NVIDIA Claymore 11.6 - Pirl LESS THAN 200 MH/s Only Cryptopools.info
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://pirl.Cryptopools.info:8002 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pirl3
ECHO AMD and NVIDIA Claymore 11.6 - Pirl 200 MH/s to 800 MH/s Only Cryptopools.info
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://pirl.Cryptopools.info:8004 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pirl4
ECHO AMD and NVIDIA Claymore 11.6 - Pirl MORE THAN 800 MH/s Only Cryptopools.info
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://pirl.Cryptopools.info:8008 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Expanse Miner
::

:exp1
ECHO AMD and NVIDIA Claymore 11.6 - Expanse to expmine.pro
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://us.expmine.pro:9009 -ewal %EXP_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -esm 0 -allcoins exp -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ellaism Miners
::

:ella1
ECHO AMD and NVIDIA Claymore 11.6 - Ella LESS THAN 180 MH/s ellaismpool US Based
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ellaismpool.com:8008 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella2
ECHO AMD and NVIDIA Claymore 11.6 - Ella 100 MH/s to 800 MH/s ellaismpool US Based
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ellaismpool.com:8004 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella3
ECHO AMD and NVIDIA Claymore 11.6 - Ella MORE THAN 800 MH/s ellaismpool US Based
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ellaismpool.com:8009 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella4
ECHO AMD and NVIDIA Claymore 11.6 - Ella LESS THAN 180 MH/s cryptobitpool.eu Europe Based
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ella.cryptobitpool.eu:8002 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella5
ECHO AMD and NVIDIA Claymore 11.6 - Ella 100 MH/s to 800 MH/s cryptobitpool.eu Europe Based
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ella.cryptobitpool.eu:8003 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella6
ECHO AMD and NVIDIA Claymore 11.6 - Ella MORE THAN 800 MH/s cryptobitpool.eu Europe Based
Miners\Claymore_ETH_Miner_v11.6\EthDcrMiner64.exe -epool stratum+tcp://ella.cryptobitpool.eu:8004 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: ZCash Miners
::
:zcash1
ECHO ZCash Claymore - Zcash to Nanopool AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool ssl://zec-us-east1.nanopool.org:6633 -zwal %ZCASH_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -zpsw %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zcash2
ECHO NVIDIA DSTM Zcash Miner - Zcash to Nanopool NVIDIA Only
Miners\zm_0.6_win\zm --server zec-us-east1.nanopool.org --port 6666 --user %ZCASH_WALLET_ADDRESS% --pass %WORKER_PASSWORD%  --color 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Komodo Miners
::
:komodo1
ECHO Claymore AMD - Komodo to Suprnova.cc
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool stratum+tcp://kmd.suprnova.cc:6250 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:komodo2
ECHO NVIDIA DSTM ZMiner - Komodo to Suprnova.cc
Miners\zm_0.6_win\zm --server kmd.suprnova.cc  --port 6250 --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: BTC Private Miners
::
:btcp1
ECHO Claymore AMD - BTCP to btcprivate.org
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool pool2.btcprivate.org:3032 -zwal %BTCP1_WALLET_ADDRESS% -zpsw %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:btcp2
ECHO NVIDIA DSTM Miner - BTCP to btcprivate.org
Miners\zm_0.6_win\zm --server pool2.btcprivate.org --port 3032 --user %BTCP1_WALLET_ADDRESS% --pass %WORKER_PASSWORD%  --color 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Zclassic Miners
::
:zcl1
ECHO ZClassic Claymore - Zclassic to miningpoolhub - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool us-east.equihash-hub.miningpoolhub.com:20575 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zcl2
ECHO NVIDIA DSTM Miner - Zclassic to miningpoolhub
Miners\zm_0.6_win\zm --server us-east.equihash-hub.miningpoolhub.com --port 20575 --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD%  --color 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: ZENCash Miners
::
:zen1
ECHO ZENCoin Claymore - ZENCash to Suprnova.cc - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool stratum+tcp://zen.suprnova.cc:3618 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen2
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCash to Suprnova.cc
Miners\DSTM_zm_0.5.4_win\zm.exe --dev --server zen.suprnova.cc --port 3618 --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit

:zen3
ECHO ZENCoin Claymore - ZENCash to Zhash.pro - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool us1.zhash.pro:3059 -zwal %ZEN_WALLET_ADDRESS%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen4
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCash to Zhash.pro
Miners\DSTM_zm_0.5.4_win\zm.exe --dev --server us1.zhash.pro --port 3059 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Zcoin Miners
::

:zcoin1
ECHO Nevermore 0.2.2 - Nvidia Only - Zcoin to Miningpoolhub
Miners\nevermore-v0.2.2-win64\ccminer -a lyra2z -o stratum+tcp://us-east.lyra2z-hub.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zcoin2
ECHO Brians SGMinger AMD 0.4.0 - Zcoin to Miningpoolhub
Miners\sgminer-x16r-v0.4.0-windows\sgminer.exe -k lyra2z -o stratum+tcp://us-east.lyra2z-hub.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: FTC Miners
::

:ftc1
ECHO Nevermore 0.2.2 - Nvidia Only - FTC to P2Pool FTC
Miners\nevermore-v0.2.2-win64\ccminer -a neoscrypt -o stratum+tcp://46.4.0.101:19327 -u %FTC_WALLET_ADDRESS% -p %WORKER_PASSWORD%  -N60 -i %I%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ftc2
ECHO AMD NSGMiner Feathercoin Miner - FTC to P2Pool FTC
Miners\nsgminer-win64-0.9.4\nsgminer.exe --neoscrypt -g 1 -w 128 -I %I% -o stratum+tcp://46.4.0.101:19327 -O %FTC_WALLET_ADDRESS%:%WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Digibyte Miners
::

:dgb1
ECHO Brians SGMinger AMD 0.4.0 GROESTL - Digibyte to Suprnova.cc
Miners\sgminer-x16r-v0.4.0-windows\sgminer.exe -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I %I% -g 4 -w 128 -k myriadcoin-groestl --no-submit-stale
if %ERRORLEVEL% NEQ 0 goto exit
pause

:dgb2
ECHO Nevermore 0.2.2 - Nvidia Only - Digibyte to Suprnova.cc
Miners\nevermore-v0.2.2-win64\ccminer -a myr-gr -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% 
if %ERRORLEVEL% NEQ 0 goto exit
pause


::
:: Monero Miners
::

:monero1
ECHO XMRig 2.5.2 NVIDIA - XMR to Nanopool
Miners\cryptonight\XMR\xmrig-NVIDIA
if %ERRORLEVEL% NEQ 0 goto exit
pause

:monero2
ECHO XMRig 2.5.2 AMD - XMR to Nanopool
Miners\cryptonight\XMR\xmrig-AMD
if %ERRORLEVEL% NEQ 0 goto exit
pause

:monero3
ECHO CAST XMR Vega 0.9.2 - XMR to Nanopool for RX VEGA
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S xmr-us-east1.nanopool.org:14444 -u %XMR_WALLET_ADDRESS%.%MINER_NAME% %*
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Electroneum Miners
::

:etn1
ECHO XMRig 2.5.2 NVIDIA - Electroneum to easyhash.io
Miners\cryptonight\ETN\xmrig-NVIDIA
if %ERRORLEVEL% NEQ 0 goto exit
pause

:etn2
ECHO XMRig 2.5.2 AMD - Electroneum to easyhash.io
Miners\cryptonight\ETN\xmrig-AMD
if %ERRORLEVEL% NEQ 0 goto exit
pause

:etn3
ECHO CAST XMR Vega 0.9.2 - XMR to Electroneum to easyhash.io 
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S etn.easyhash.io:3632 -u %ETN_WALLET_ADDRESS%.%MINER_NAME% %*
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Sumokoin Miners
::

:sumo1
ECHO XMRig 2.5.2 NVIDIA - Sumo to easyhash.io 
Miners\cryptonight\SUMO\xmrig-NVIDIA
if %ERRORLEVEL% NEQ 0 goto exit
pause

:sumo2
ECHO XMRig 2.5.2 AMD - Sumo to easyhash.io 
Miners\cryptonight\SUMO\xmrig-AMD
if %ERRORLEVEL% NEQ 0 goto exit
pause

:sumo3
ECHO CAST XMR Vega 0.9.2 - Sumo to easyhash.io 
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S sumo.easyhash.io:3332 -u %SUMO_WALLET_ADDRESS%.%MINER_NAME% %*
pause

::
:: Karbowanec Miners
::

:karb1
ECHO XMRig 2.5.5 NVIDIA - Sumo to easyhash.io  - Karbowanec to easyhash.io 
Miners\cryptonight\KARB\xmrig-NVIDIA
if %ERRORLEVEL% NEQ 0 goto exit
pause

:karb2
ECHO XMRig 2.5.5 AMD - Karbowanec to easyhash.io
Miners\cryptonight\KARB\xmrig-AMD
if %ERRORLEVEL% NEQ 0 goto exit
pause

:karb3
ECHO CAST XMR Vega 0.9.2 - Karbowanec to easyhash.io
Miners\cast_xmr-vega-win64_092\cast_xmr-vega -S krb.easyhash.io:3532 -u %KRB_WALLET_ADDRESS%.%MINER_NAME% %*
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Bulkwark Miners
::

:bulk1
ECHO Brians SGMinger AMD 0.4.0 Bulkwark to bsod.pw 
Miners\sgminer-x16r-v0.4.0-windows\sgminer.exe -k NIST5 -o stratum+tcp://pool.bsod.pw:3833 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:bulk2
ECHO Nevermore 0.2.2 - Nvidia Only - Bulkwark to bsod.pw 
Miners\nevermore-v0.2.2-win64\ccminer -a NIST5 -o stratum+tcp://pool.bsod.pw:3833 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: RavenCoin Miners
::

:rvn1
ECHO Brians SGMinger AMD 0.4.0 - RavenCoin to Threeyed
Miners\sgminer-x16r-v0.4.0-windows\sgminer.exe -k x16r -o stratum+tcp://stratum.threeeyed.info:3333 -u %RVN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:rvn2
ECHO Nevermore 0.2.2 - Nvidia Only - RavenCoin to Threeyed
Miners\nevermore-v0.2.2-win64\ccminer -a x16r -o stratum+tcp://stratum.threeeyed.info:3333 -u %RVN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:rvn3
ECHO Enemy 1.3.0 - Nvidia Only - RavenCoin to Threeyed
Miners\Enemy-ccminer.1.3.0\ccminer -a x16r -o stratum+tcp://stratum.threeeyed.info:3333 -u %RVN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:rvn4
ECHO Suprminer 1.6.0 - Nvidia Only - RavenCoin to Threeyed
Miners\suprminer-1.6\ccminer -a x16r -o stratum+tcp://stratum.threeeyed.info:3333 -u %RVN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Pigeoncoin Miners
::

:pgn1
ECHO Brians SGMinger AMD 0.4.0 - Pigeoncoin to Blockcruncher
Miners\sgminer-x16r-v0.4.0-windows\sgminer.exe -k x16s -o stratum+tcp://blockcruncher.com:3636 -u %PGN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pgn2
ECHO Nevermore 0.2.2 - Nvidia Only - Pigeoncoin to Blockcruncher
Miners\nevermore-v0.2.2-win64\ccminer -a x16s -o stratum+tcp://blockcruncher.com:3636 -u %PGN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -i %I% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Vertcoin Miner
::
:vtc1
ECHO Mkxminer 3.1.0 - AMD Only - Vertcoin to Miningpoolhub 
Miners\mkxminer310\mkxminer -a Lyra2rev2 -o stratum+tcp://vtc.suprnova.cc:5678 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I% --platform %platform%

:vtc2
ECHO Nevermore 0.2.2 - Nvidia Only - Vertcoin to Miningpoolhub
Miners\nevermore-v0.2.2-win64\ccminer -a Lyra2rev2 -o stratum+tcp://hub.miningpoolhub.com:20507 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%

::
:: MonaCoin Miners
::
:mona1
ECHO Mkxminer 3.1.0 - AMD Only - Monacoin to Miningpoolhub
Miners\mkxminer310\mkxminer -a Lyra2rev2 -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I% --platform %platform%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mona2
ECHO Nevermore 0.2.2 - Nvidia Only - Monacoin to Miningpoolhub
Miners\nevermore-v0.2.2-win64\ccminer  -a Lyra2rev2 -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -i %I%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:EOF
