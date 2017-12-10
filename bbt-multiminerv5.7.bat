@echo off
setlocal EnableDelayedExpansion 
rem **********************************************************************
rem *         BBT Multi-Miner Easy Batch File  v5.7 by BBT               *
rem *     Featuring Claymore, SGMiner, CCMiner, EBWF's Miner and more    *
rem *   Pre-Configured syntax, just update address/worker                *
rem *    Eth, Etc, Xmr, Lbry, Sia, Zcash, Pasc, Hush, DBIX, ubiq and more*
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

rem *** Miner login for pools like suprnova.cc
rem *** dont get excited, our primary mining weblogin is not bitsbetrippin, used as example
rem *** MUST UPDATE JSON FILE FOR NVIDIA XMR FOR USER INFO

SET MINER_WEBLOGIN=%MINER-WEBLOGIN%
SET WORKER_PASSWORD=%WORKER-PASSWORD%
SET MINER_NAME=%MINER-NAME%
SET EMAIL_ADDRESS=%EMAIL-ADDRESS%

setx GPU_FORCE_64BIT_PTR 0 >nul 2>&1
setx GPU_MAX_HEAP_SIZE 100 >nul 2>&1
setx GPU_USE_SYNC_OBJECTS 1 >nul 2>&1
setx GPU_MAX_ALLOC_PERCENT 100 >nul 2>&1
setx GPU_SINGLE_ALLOC_PERCENT 100 >nul 2>&1

:: All Pools used in Multi-Miner and reference to what Tokens they support 
:: ** Note not all tokens are included in Multi-Miner

::  https://nanopool.org/
::  Ethereum, Ethereum Classic, SiaCoin, Zcash, Monero, Pascal

::  https://miningpoolhub.com/
::  Adzcoin, Auroracoin (Qubit), Bitcoin, Bitcoin-Cash, Dash, Digibyte (Groestl), Digibyte (Qubit), Digibyte (Skein), Ethereum, Ethereum-Classic, 
::  Expanse, Feathercoin, Gamecredits, Geocoin, Globalboosty, Groestlcoin, Litecoin, Maxcoin, Monacoin, Monero, Musicoin, Myriadcoin (Groestl), 
::  Myriadcoin (Skein), Myriadcoin (Yescrypt), Sexcoin, Siacoin, Startcoin, Verge (Scrypt), Vertcoin, Zcash, Zclassic, Zcoin

::  https://www.suprnova.cc/
::  Bitcoin Gold Testnet, Lbry Credits, SmartCash, Minexcoin, ZCLASSIC, ZENCash, ZCASH, BitcoinZ, XIOS, ZCoin, 
::  Pure, BitSend, BitCore, MachineCoin, Einsteinium, Komodo, ZDASH, Monero, DashCoin, ZeroCoin, Bitcoin Cash,
::  Ethereum, UBIQ, Expanse, Decred, Chaincoin, eMark, Siberian Chervonets, EuropeCoin V3, HOdlcoin V3 MonaCoin,
::  GroestlCoin Myriad-Groestl, Digibyte Myriad-Groestl, Digibyte Qubit, Skein, GameCredits, SpreadCoin, StartCoin
::  FlorinCoin, GeoCoin, Qubit, Litecoin+Via MM, MagiCoin

::  http://ubiq.hodlpool.com/#/
::  Ubiq

::  http://exp.hodlpool.com/
::  Expanse

::  https://eu2.electromine.fr/
::  Electroneum

::  https://ethermine.org/
::  Ethereum

::  http://dbix.pool.sexy/
::  Dbix

::  http://46.4.0.101/  - Feathercoin P2P Mining Network
::  Feathercoin

::  http://pirl.minerpool.net/#/ 
::  PIRL Mining Pool

::  https://btg.minertopia.org/
::  BTG 

::  http://ella.cryptobitpool.eu/
::  http://ellaismpool.com/#/
::    Ellaism

::  https://easyhash.io/
::    ETN, KRB, SUMO

::  http://equihash.hodlpool.com/
::   ZEC, KMD, ZEN, ZEC
	
SET miner=%1

IF NOT "%miner%"=="" (
    SET /A M=%miner%
    goto MinerSwitch
)
ECHO ====================================================
ECHO *                    ETHEREUM (ETH)                *
ECHO ====================================================
ECHO 1.  Optimized Ethminer AMD and NVIDIA - Eth Ethermine.org Only
ECHO 2.  Optimized Ethminer AMD and NVIDIA - Eth Nanopool Only
ECHO 3.  AMD and NVIDIA Claymore - Eth Only Ethermine.org
ECHO 4.  AMD and NVIDIA Claymore - Eth Ethermine.org and Siacoin to Nanopool
ECHO 5.  AMD and NVIDIA Claymore - Eth Ethermine.org and Decred to CoinMine.pl
ECHO 6.  AMD and NVIDIA Claymore - Eth Ethermine.org and Lbry Credits to Coinmine.pl
ECHO 7.  AMD and NVIDIA Claymore - Eth Ethermine.org and PascalCoin to Nanopool
ECHO 8.  AMD and NVIDIA Claymore - Eth Nanopool Only
ECHO 9.  AMD and NVIDIA Claymore - Eth Nanopool and Siacoin to Nanopool
ECHO 10. AMD and NVIDIA Claymore - Eth Nanopool and Pascal to Nanopool
ECHO ====================================================
ECHO *                    ETHEREUM Classic (ETC)        *
ECHO ====================================================
ECHO 11. Optimized Ethminer AMD and NVIDIA - Etc nanopool
ECHO 12. AMD and NVIDIA Claymore - Etc (ethereum classic) to Nanopool
ECHO 13. AMD and NVIDIA Claymore - Etc (ethereum classic) and Siacoin both to Nanopool
ECHO 14. AMD and NVIDIA Claymore - Etc (ethereum classic) Nanopool and Decred to CoinMine.pl
ECHO ====================================================
ECHO *                    Komodo (KMD)                  *
ECHO ====================================================
ECHO 15.  NVIDIA DSTM ZMiner - Komodo to HODLPool
ECHO ====================================================
ECHO *                    Monero (XMR)                  *
ECHO ====================================================
ECHO 16.  Claymore CryptoNote 9.7 AMD Only - XMR to Nanopool
ECHO 17.  Claymore CryptoNote 10.2 AMD Only - XMR to Nanopool
ECHO 18.  CAST VEGA Miner - XMR to Nanopool for RX VEGA
ECHO ====================================================
ECHO *                    ZCASH (ZEC)                   *
ECHO ====================================================
ECHO 19.  AMD ZCash Claymore - Zcash to Nanopool AMD Only
ECHO 20.  Nicehash Excavator - Zcash to Nanopool Both AMD and Nvidia
ECHO 21.  NVIDIA EWBF's CUDA Zcash Miner - Zcash to Nanopool NVIDIA Only
ECHO ====================================================
ECHO *                    SIACOIN (SIA)                 *
ECHO ====================================================
ECHO 22.   AMD and NVIDIA Gominer - Siacoin to Nanopool Only
ECHO ====================================================
ECHO *                    PASCALCOIN (PASC)             *
ECHO ====================================================
ECHO 23.  AMD SGMiner PascalCoin (exchange address) - PascalCoin to Nanopool
ECHO 24.  NiceHash Excavator 1.2.11a - PascalCoin to Nanopool
ECHO ====================================================
ECHO *                    HUSH (HUSH)                   *
ECHO ====================================================
ECHO 25.  HUSH Claymore - Hush to HODLPool AMD Only SECURE SSL
ECHO 26.  NVIDIA EWBF's CUDA HUSH Miner - HUSH to HODLPool NVIDIA Only
ECHO ====================================================
ECHO *                    LBRY (LBC)                    *
ECHO ====================================================
ECHO 27.  NVIDIA CCMiner Lbry Credits Miner - Lbry to coinmine.pl NVIDIA ONLY
ECHO 28.  SGMiner Lbry Credits Miner - Lbry to coinmine AMD ONLY
ECHO ====================================================
ECHO *                    DBIX (DBIX)                   *
ECHO ====================================================
ECHO 29.  AMD and NVIDIA Claymore - DBIX to Sexy.Pool Only
ECHO 30.  AMD and NVIDIA Claymore - Dbix to Sexy.Pool and Siacoin to Nanopool
ECHO 31.  AMD and NVIDIA Claymore - Dbix to Sexy.Pool and Decred to Suprnova.cc Pool
ECHO 32.  AMD and NVIDIA Claymore - Dbix to Sexy.Pool and LBRY to Coinmine.pl
ECHO ====================================================
ECHO *                    UBIQ (UBQ)                    *
ECHO ====================================================
ECHO 33.  AMD and NVIDIA Claymore - Ubiq to Hodl Pool
ECHO 34.  AMD and NVIDIA Claymore - Ubiq to Hodl Pool and Decred to Coinmine.pl
ECHO 35.  AMD and NVIDIA Claymore - Ubiq to Hodl Pool and LBRY to Coinmine.pl
ECHO 36.  AMD and NVIDIA Claymore - Ubiq to Hodl Pool and PASC to Nanopool
ECHO 37.  AMD and NVIDIA Claymore - Ubiq to Hodl Pool and Siacoin to Nanopool
ECHO ====================================================
ECHO *                    Expanse (EXP)                 *
ECHO ====================================================
ECHO 38.  AMD and NVIDIA Claymore - Expanse to Hodl Pool
ECHO ====================================================
ECHO *                    Bitcoin Gold (BTG)            *
ECHO ====================================================
ECHO 39.  AMD Claymore - BTG to minertopia AMD Only
ECHO 40.  NVIDIA EWBF's CUDA Miner - BTG to minertopia NVIDIA Only 
ECHO ====================================================
ECHO *                    Digibyte (DGB)                *
ECHO ====================================================
ECHO 41.  AMD SGMiner DGB Miner GROESTL - Digibyte to Suprnova.cc AMD Only
ECHO 42.  CCMiner NVIDIA - DGB GROESTL to Suprnova.cc
ECHO ====================================================
ECHO *                    Feathercoin (FTC)             *
ECHO ====================================================
ECHO 43.  NVIDIA only - FTC to F2Pool FTC
ECHO 44.  AMD NSGMiner Feathercoin Miner - FTC to P2Pool FTC
ECHO ====================================================
ECHO *                    Musicoin (MUS)                *
ECHO ====================================================
ECHO 45.  AMD and NVIDIA Claymore - Musicoin to miningpoolhub Only
ECHO 46.  AMD and NVIDIA Claymore - Musicoin to miningpoolhub Siacoin to Nanopool
ECHO 47.  AMD and NVIDIA Claymore - Musicoin to miningpoolhub Decred to Coinmine.pl Pool
ECHO 48.  AMD and NVIDIA Claymore - Musicoin to miningpoolhub Lbry Credits to Coinmine.pl
ECHO 49.  AMD and NVIDIA Claymore - Musicoin to miningpoolhub PascalCoin to Nanopool
ECHO ====================================================
ECHO *                    Electroneum (ETN)             *
ECHO ====================================================
ECHO 50.  CAST VEGA Miner - Electroneum to easyhash.io - Mining Rig Difficulty for RX VEGA
ECHO 51.  Claymore CryptoNote 9.7 AMD Only - Electroneum to easyhash.io - For R9 / RX Series
ECHO 52.  Claymore CryptoNote 10.2 AMD Only - Electroneum to easyhash.io - For VEGA
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Zclassic (ZCL)                *
ECHO ====================================================
ECHO 53.  Claymore Zclassic AMD Only - Zclassic to Miningpoolhub
ECHO 54.  Silentarmy Zclassic nVidia GPU Only - Zclassic to Miningpoolhub
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Zcoin (XZC)                   *
ECHO ====================================================
ECHO 55.  CCMiner YIIMP - Nvidia Only - Zcoin to Miningpoolhub
ECHO 56.  SGMiner - AMD Only - Zcoin to Miningpoolhub
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Vertcoin (VTC)                *
ECHO ====================================================
ECHO 57.  Vertcoin - CCMiner YIIMP - Nvidia Only - Vertcoin to Miningpoolhub
ECHO ****************************************************
ECHO ====================================================
ECHO *                    ZENCash (ZEN)                 *
ECHO ====================================================
ECHO 58.  Claymore ZENCoin AMD Only - Zencoin to Suprnova.cc
ECHO 59.  NVIDIA DSTM ZMiner - nVidia Only - ZENCOIN to Suprnova.cc
ECHO 60.  ZENCoin Claymore - ZENCash to HODLPool - AMD Only
ECHO 61.  NVIDIA DSTM ZMiner - nVidia Only - ZENCash to HODLPool
ECHO ****************************************************
ECHO ====================================================
ECHO *                    PIRL (PIRL)                   *
ECHO ====================================================
ECHO 62.  AMD and NVIDIA Claymore - Pirl LESS THAN 100 MH/s Only minerpool.net
ECHO 63.  AMD and NVIDIA Claymore - Pirl 100 MH/s to 800 MH/s Only minerpool.net
ECHO 64.  AMD and NVIDIA Claymore - Pirl MORE THAN 800 MH/s Only minerpool.net
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Ellaism (ELLA)                *
ECHO ====================================================
ECHO 65.  AMD and NVIDIA Claymore - Ella LESS THAN 180 MH/s ellaismpool America Based
ECHO 66.  AMD and NVIDIA Claymore - Ella 100 MH/s to 800 MH/s ellaismpool America Based
ECHO 67.  AMD and NVIDIA Claymore - Ella MORE THAN 800 MH/s ellaismpool America Based
ECHO 68.  AMD and NVIDIA Claymore - Ella LESS THAN 100 MH/s Only minerpool.net
ECHO 69.  AMD and NVIDIA Claymore - Ella 100 MH/s to 800 MH/s Only minerpool.net
ECHO 70.  AMD and NVIDIA Claymore - Ella MORE THAN 800 MH/s Only minerpool.net
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Sumokoin (SUMO)               *
ECHO ====================================================
ECHO 71.  CAST VEGA Miner - Sumokoin to easyhash.io - Mining Rig Difficulty for RX VEGA
ECHO 72.  Claymore CryptoNote 9.7 AMD Only - Sumokoin to easyhash.io - For R9 / RX Series
ECHO 73.  Claymore CryptoNote 10.2 AMD Only - Sumokoin to easyhash.io - For VEGA
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Karbowanec (KRB)              *
ECHO ====================================================
ECHO 74.  CAST VEGA Miner - Karbowanec to easyhash.io - Mining Rig Difficulty for RX VEGA
ECHO 75.  Claymore CryptoNote 9.7 AMD Only - Karbowanec to easyhash.io - For R9 / RX Series
ECHO 76.  Claymore CryptoNote 10.2 AMD Only - Karbowanec to easyhash.io - For VEGA
ECHO ****************************************************
ECHO ====================================================
ECHO *                    Zcash (ZEC) /HODLPool\        *
ECHO ====================================================
ECHO 77.  AMD ZCash Claymore - Zcash to HODLPool AMD Only
ECHO 78.  NVIDIA EWBF's CUDA Zcash Miner - Zcash to HODLPool NVIDIA Only
ECHO ****************************************************
ECHO ====================================================
ECHO *                    MonaCoin (MONA)               *
ECHO ====================================================
ECHO 79.  CCMiner YIIMP - Nvidia Only - Zcoin to Miningpoolhub
ECHO 80.  SGMiner - AMD Only - Monacoin to Miningpoolhub   
ECHO ****************************************************
ECHO 99 - EXIT
ECHO.

:: Get input from user
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
if %ERRORLEVEL% NEQ 0 goto EOF

:: Is choice a number?
SET "var="&for /f "delims=0123456789" %%i in ("%M%") do set var=%%i
if defined var goto EOF

:MinerSwitch
IF %M%==1 GOTO ethereum1
IF %M%==2 GOTO ethereum2
IF %M%==3 GOTO ethereum3
IF %M%==4 GOTO ethereum4
IF %M%==5 GOTO ethereum5
IF %M%==6 GOTO ethereum6
IF %M%==7 GOTO ethereum7
IF %M%==8 GOTO ethereum8
IF %M%==9 GOTO ethereum9
IF %M%==10 GOTO ethereum10
IF %M%==11 GOTO ethereumc1
IF %M%==12 GOTO ethereumc2
IF %M%==13 GOTO ethereumc3
IF %M%==14 GOTO ethereumc4
IF %M%==15 GOTO komodo1
IF %M%==16 GOTO monero1
IF %M%==17 GOTO monero2
IF %M%==18 GOTO monero3
IF %M%==19 GOTO zcash1
IF %M%==20 GOTO zcash2
IF %M%==21 GOTO zcash3
IF %M%==22 GOTO siacoin1
IF %M%==23 GOTO pascal1
IF %M%==24 GOTO pascal2
IF %M%==25 GOTO hush1
IF %M%==26 GOTO hush2
IF %M%==27 GOTO lbry1
IF %M%==28 GOTO lbry2
IF %M%==29 GOTO dbix1
IF %M%==30 GOTO dbix2
IF %M%==31 GOTO dbix3
IF %M%==32 GOTO dbix4
IF %M%==33 GOTO ubiq2
IF %M%==34 GOTO ubiq3
IF %M%==35 GOTO ubiq4
IF %M%==36 GOTO ubiq5
IF %M%==37 GOTO ubiq6
IF %M%==38 GOTO exp1
IF %M%==39 GOTO btg1
IF %M%==40 GOTO btg2
IF %M%==41 GOTO dgb1
IF %M%==42 GOTO dgb2
IF %M%==43 GOTO ftc1
IF %M%==44 GOTO ftc2
IF %M%==45 GOTO mus1
IF %M%==46 GOTO mus2
IF %M%==47 GOTO mus3
IF %M%==48 GOTO mus4
IF %M%==49 GOTO mus5
IF %M%==50 GOTO etn1
IF %M%==51 GOTO etn2
IF %M%==52 GOTO etn3
IF %M%==53 GOTO zcl1
IF %M%==54 GOTO zcl2
IF %M%==55 GOTO xzc1
IF %M%==56 GOTO xzc2
IF %M%==57 GOTO vtc1
IF %M%==58 GOTO zen1
IF %M%==59 GOTO zen2
IF %M%==60 GOTO zen3
IF %M%==61 GOTO zen4
IF %M%==62 GOTO pirl1
IF %M%==63 GOTO pirl2
IF %M%==64 GOTO pirl3
IF %M%==65 GOTO ella1
IF %M%==66 GOTO ella2
IF %M%==67 GOTO ella3
IF %M%==68 GOTO ella4
IF %M%==69 GOTO ella5
IF %M%==70 GOTO ella6
IF %M%==71 GOTO sumo1
IF %M%==72 GOTO sumo2
IF %M%==73 GOTO sumo3
IF %M%==74 GOTO krb1
IF %M%==75 GOTO krb2
IF %M%==76 GOTO krb3
IF %M%==77 GOTO zcash4
IF %M%==78 GOTO zcash5
IF %M%==79 GOTO mona1
IF %M%==80 GOTO mona1
IF %M% GTR 81 GOTO EOF

::
:: Ethereum miners
::
:ethereum1
ECHO Optimized Ethminer AMD and NVIDIA - Eth Ethermine.org Only
Miners\ethminer-0.12.0rc1\bin\ethminer.exe --farm-recheck 200 -G -S eu1.ethermine.org:4444 -FS us1.ethermine.org:4444 -O %ETH_WALLET_ADDRESS%.%MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum2
ECHO Optimized Ethminer AMD and NVIDIA - Eth Nanopool Only
Miners\ethminer-0.12.0rc1\bin\ethminer.exe --farm-recheck 200 -G -S eth-us-east1.nanopool.org:9999 -FS eth-eu1.nanopool.org:9999 -O %ETH_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum3
ECHO AMD and NVIDIA Claymore - Eth Only Ethermine.org
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool us1.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum4
ECHO AMD and NVIDIA Claymore - Eth Ethermine.org and Siacoin to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool us1.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD% -dpool stratum+tcp://sia-us-east1.nanopool.org:7777 -dwal %SIA_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -dcoin sia
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum5
ECHO AMD and NVIDIA Claymore - Eth Ethermine.org and Decred to CoinMine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool us1.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD% -dpool dcr-us.coinmine.pl:2222 -dwal %MINER_WEBLOGIN%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum6
ECHO AMD and NVIDIA Claymore - Eth Ethermine.org and Lbry Credits to Coinmine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool us1.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD% -dpool lbc-us.coinmine.pl:8787 -dwal %MINER_WEBLOGIN%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -dcoin lbc
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum7
ECHO AMD and NVIDIA Claymore - Eth Ethermine.org and PascalCoin to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool us1.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD% -dpool stratum+tcp://pasc-us-east1.nanopool.org:15555 -dwal %PASCAL_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -dpsw %WORKER_PASSWORD% -dcoin pasc -ftime 10 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum8
ECHO AMD and NVIDIA Claymore - Eth Nanopool Only
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool eth-us-east1.nanopool.org:9999 -ewal %ETH_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum9
ECHO AMD and NVIDIA Claymore - Nanopool and Siacoin to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool eth-us-east1.nanopool.org:9999 -ewal %ETH_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD% -dpool stratum+tcp://sia-us-east1.nanopool.org:7777 -dwal %SIA_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -dcoin sia
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum10
ECHO AMD and NVIDIA Claymore - Eth Nanopool and Pascal to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool eth-us-east1.nanopool.org:9999 -ewal %ETH_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD% -dpool stratum+tcp://pasc-us-east1.nanopool.org:15555 -dwal %PASCAL_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -dcoin pasc -ftime 10 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ethereum Classic miners
::
:ethereumc1
ECHO Optimized Ethminer AMD and NVIDIA - Etc nanopool 
Miners\ethminer-0.12.0rc1\bin\ethminer.exe --farm-recheck 200 -G -S etc-us-east1.nanopool.org:19999 -O %ETC_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereumc2
ECHO AMD and NVIDIA Claymore - Etc (ethereum classic) to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool etc-us-east1.nanopool.org:19999 -ewal %ETC_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereumc3
ECHO AMD and NVIDIA Claymore - Etc (ethereum classic) and Siacoin both to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool etc-us-east1.nanopool.org:19999 -ewal %ETC_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD% -dpool stratum+tcp://sia-us-east1.nanopool.org:7777 -dwal %SIA_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -dcoin sia -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereumc4
ECHO AMD and NVIDIA Claymore - Etc (ethereum classic) Nanopool and Decred to Coinmine
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool etc-us-east1.nanopool.org:19999 -ewal %ETC_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -epsw %WORKER_PASSWORD% -dpool dcr-us.coinmine.pl:2222 -dwal %MINER_WEBLOGIN%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Komodo Miners
::
:komodo1
ECHO NVIDIA DSTM ZMiner - Komodo to HODLPool
Miners\DSTM_zm_0.5.4_win\zm.exe --dev --server mining.hodlpool.com  --port 3035 --user %KMD_WALLET_ADDRESS% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Monero Miners
::
:monero1
ECHO Claymore CryptoNote 9.7 AMD Only - XMR to Nanopool
Miners\Claymore_CryptoNote_GPU_Miner_v9.7\NsGpuCNMiner.exe -o ssl://xmr-eu1.nanopool.org:14433 -u %XMR_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -p %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:monero2
ECHO Claymore CryptoNote 10.2 AMD Only - XMR to Nanopool
Miners\Claymore_CryptoNote_AMDv10.2\NsGpuCNMiner.exe -xpool ssl://xmr-eu1.nanopool.org:14433 -xwal %XMR_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -xpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:monero3
ECHO CAST VEGA Miner - XMR to Nanopool for RX VEGA
Miners\cast_xmr-vega-win64_070\cast_xmr-vega -S xmr-us-east1.nanopool.org:14444 -u %XMR_WALLET_ADDRESS%.%MINER_NAME% %*
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
ECHO Nicehash Excavator - Zcash to Nanopool
Miners\excavator_v1.2.11a\excavator+web+restart_script.bat
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zcash3
ECHO NVIDIA EWBF's CUDA Zcash Miner - Zcash to Nanopool NVIDIA Only
Miners\ZEC_M0.3.4b\miner --server zec-us-east1.nanopool.org --user %ZCASH_WALLET_ADDRESS%.%MINER_NAME%.%EMAIL_ADDRESS% --pass %WORKER_PASSWORD% --port 6666 --pec
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: SiaCoin Miners
::
:siacoin1
ECHO AMD and NVIDIA Gominer - Siacoin to Nanopool Only
Miners\gominer-windows-1.0.0\gominer.exe -I 28 -H sia-us-east1.nanopool.org:9980 -Q "address=%SIA_WALLET_ADDRESS%&worker=%MINER_NAME%&email=%EMAIL_ADDRESS%"
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: PascalCoin Miners
::
:pascal1
ECHO AMD SGMiner PascalCoin (exchange address) - PascalCoin to Nanopool
Miners\sg-miner-5.5.0\sgminer.exe -k pascal -o stratum+tcp://pasc-us-east1.nanopool.org:15555 -u %PASCAL_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -p %WORKER_PASSWORD% -I 21 -w 64 -g2 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pascal2
ECHO Nicehash Excavator - PascalCoin to Nanopool
Miners\excavator_v1.2.11a\pasc_excavator+web+restart_script.bat
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Hush Miners
::
:hush1
ECHO Hush Claymore - Hush to HODLPool AMD Only 
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool mining.hodlpool.com:3034 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:hush2
ECHO NVIDIA EWBF's CUDA HUSH Miner - HUSH to HODLPool NVIDIA Only
Miners\ZEC_M0.3.4b\miner --server mining.hodlpool.com --user %MINER_WEBLOGIN%.%MINER_NAME% --pass %WORKER_PASSWORD% --port 3034 --zec
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Lbry Miners
::
:lbry1
ECHO NVIDIA CCMiner Lbry Credits Miner - Lbry to coinmine.pl NVIDIA ONLY
Miners\ccminer-x64-2.2.1\ccminer-x64.exe -o stratum+tcp://lbc-us.coinmine.pl:8787 -u %LBRY_WALLET_ADDRESS%.%MINER_NAME% -a lbry -p %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:lbry2
ECHO SGMiner Lbry Credits Miner - Lbry to coinmine AMD ONLY
Miners\sgminer_5_4_0-lbry\sgminer.exe --kernel lbry -o stratum+tcp://lbc-us.coinmine.pl:8787 -u %LBRY_WALLET_ADDRESS%.%MINER_NAME% -p %WORKER_PASSWORD% -I 19 -w 64 -g 4
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Dbix Miners
::
:dbix1
ECHO AMD and NVIDIA Claymore - Dbix to Sexy.pool only
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://dbix.pool.sexy:7007 -ewal %DBIX_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -allpools 1 -allcoins 1 -mode 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:dbix2
ECHO AMD and NVIDIA Claymore - Dbix to Sexy.Pool and Siacoin to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://dbix.pool.sexy:7007 -ewal %DBIX_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool stratum+tcp://sia-us-east1.nanopool.org:7777 -dwal %SIA_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -dcoin sia -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:dbix3
ECHO AMD and NVIDIA Claymore - Dbix to Sexy.Pool and Decred to Coinmine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://dbix.pool.sexy:7007 -ewal %DBIX_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool dcr-us.coinmine.pl:2222 -dwal %MINER_WEBLOGIN%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:dbix4
ECHO AMD and NVIDIA Claymore - Dbix to Sexy.Pool and LBRY to Coinmine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://dbix.pool.sexy:7007 -ewal %DBIX_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool lbc-us.coinmine.pl:8787 -dwal %LBRY_WALLET_ADDRESS%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -dcoin lbc -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ubiq Miners
::


:ubiq2
ECHO AMD and NVIDIA Claymore - Ubiq to Hodl Pool Only
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBIQ_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -allpools 1 -allcoins 1 -mode 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ubiq3
ECHO AMD and NVIDIA Claymore - Ubiq to Hodl Pool and Decred to Coinmine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBIQ_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool dcr-us.coinmine.pl:2222 -dwal %MINER_WEBLOGIN%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ubiq4
ECHO AMD and NVIDIA Claymore - Ubiq to Hodl Pool and LBRY to Coinmine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBIQ_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool stratum+tcp://lbc-us.coinmine.pl:8787 -dwal %LBRY_WALLET_ADDRESS%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -dcoin lbc -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ubiq5
ECHO AMD and NVIDIA Claymore - Ubiq to Hodl Pool and PASC to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBIQ_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool stratum+tcp://pasc-us-east1.nanopool.org:15555 -dwal %PASCAL_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -dcoin pasc -ftime 10 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ubiq6
ECHO AMD and NVIDIA Claymore - Ubiq to Hodl Pool and Siacoin to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ubiq.hodlpool.com:8009 -ewal %UBIQ_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -eworker %MINER_NAME% -dpool stratum+tcp://sia-us-east1.nanopool.org:7777 -dwal %SIA_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -dcoin sia -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Expanse Miners
::

:exp1
ECHO AMD and NVIDIA Claymore - Expanse to Hodl Pool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://exp.hodlpool.com:8003 -ewal %EXP_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -esm 0 -allcoins exp -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Bitcoin Gold Miners
::

:btg1
ECHO AMD Claymore - BTG to Minertopia AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool btg.minertopia.org:5555 -zwal %BTG_WALLET_ADDRESS%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:btg2
ECHO NVIDIA EWBF's CUDA Miner - BTG to Minertopia NVIDIA Only
Miners\ZEC_M0.3.4b\miner --server btg.minertopia.org --user %BTG_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD% --port 5555 --pec
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Digibyte Miners
::

:dgb1
ECHO AMD SGMiner DGB Miner GROESTL - Digibyte to Suprnova.cc AMD Only
Miners\sgminer-5.6.1-nicehash-51-windows-amd64\sgminer.exe -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I 20 -g 4 -w 128 -k myriadcoin-groestl --no-submit-stale
if %ERRORLEVEL% NEQ 0 goto exit
pause

:dgb2
ECHO NVIDIA CCMiner DGB Miner - Digibyte to Suprnova.cc NVIDIA ONLY
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a myr-gr -o stratum+tcp://dgbg.suprnova.cc:7978 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: FTC Miners
::

:ftc1
ECHO NVIDIA CCMiner Feathercoin Miner - FTC to P2Pool FTC
Miners\ccminer-x64-2.2.1\ccminer-x64.exe -o stratum+tcp://46.4.0.101:19327 -u %FTC_WALLET_ADDRESS% -p %WORKER_PASSWORD% -a neoscrypt -N60 -i 19.5
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ftc2
ECHO AMD NSGMiner Feathercoin Miner - FTC to P2Pool FTC
Miners\nsgminer-win64-0.9.2\nsgminer.exe --neoscrypt -g 1 -w 128 -I 17 -o stratum+tcp://46.4.0.101:19327 -O %FTC_WALLET_ADDRESS%:%WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause
::
:: Musicoin Miners
::

:mus1
ECHO AMD and NVIDIA Claymore - Musiccoin to miningpoolhub Pool Only
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mus2
ECHO AMD and NVIDIA Claymore - Musiccoin to miningpoolhub Pool and Siacoin to Nanopool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1 -dpool stratum+tcp://sia-us-east1.nanopool.org:7777 -dwal %SIA_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -dcoin sia -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mus3
ECHO AMD and NVIDIA Claymore - Musiccoin to miningpoolhub Pool and Decred to Suprnova.cc Pool
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1 -dpool dcr-us.coinmine.pl:2222 -dwal %MINER_WEBLOGIN%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mus4
ECHO AMD and NVIDIA Claymore - Musiccoin to miningpoolhub Pool and LBRY to Coinmine.pl
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1 -dpool stratum+tcp://lbc-us.coinmine.pl:8787 -dwal %LBRY_WALLET_ADDRESS%.%MINER_NAME% -dpsw %WORKER_PASSWORD% -dcoin lbc
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mus5
ECHO AMD and NVIDIA Claymore - Musiccoin to miningpoolhub Pool and PASC to Nanopool
Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://us-east.ethash-hub.miningpoolhub.com:20585 -ewal %MINER_WEBLOGIN%.%MINER_NAME% -epsw %WORKER_PASSWORD% -esm 2 -allcoins 1 -allpools 1 -dpool stratum+tcp://pasc-us-east1.nanopool.org:15555 -dwal %PASCAL_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -dcoin pasc -ftime 10 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Electroneum Miners
::

:etn1
ECHO CAST VEGA Miner - Electroneum to easyhash.io - Mining Rig Difficulty for RX VEGA
Miners\cast_xmr-vega-win64_070\cast_xmr-vega -S etn.easyhash.io:3632 -u %ETN_WALLET_ADDRESS%.%MINER_NAME% %*
if %ERRORLEVEL% NEQ 0 goto exit
pause

:etn2
ECHO Claymore CryptoNote 9.7 AMD Only - Electroneum to easyhash.io - For R9 / RX Series
Miners\Claymore_CryptoNote_GPU_Miner_v9.7\NsGpuCNMiner.exe -o stratum+tcp://etn.easyhash.io:3632 -u %ETN_WALLET_ADDRESS% -p %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:etn3
ECHO Claymore CryptoNote 10.2 AMD Only - Electroneum to easyhash.io - For VEGA
Miners\Claymore_CryptoNote_AMDv10.2\NsGpuCNMiner.exe -xpool stratum+tcp://etn.easyhash.io:3632 -xwal %ETN_WALLET_ADDRESS% -xpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Zclassic Miners
::
:zcl1
ECHO ZClassic Claymore - Zclassic to miningpoolhub - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool ssl://us-east.equihash-hub.miningpoolhub.com:20575 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zcl2
ECHO ZClassic Silentarmy CUDA CPU - Zclassic to miningpoolhub - nVidia GPU Only
Miners\Windows_x64_nheqminer-5c\nheqminer.exe -cd 0 -t 4 -l us-east1.zclassic.miningpoolhub.com:20575 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Zcoin Miners
::
:xzc1
ECHO CCMiner YIIMP - Nvidia Only - Zcoin to Miningpoolhub
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a lyra2z -o stratum+tcp://us-east.zcoin.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:xzc2
ECHO SGMiner - AMD Only - Zcoin to Miningpoolhub
Miners\sgminer_5_4_0-lbry\sgminer.exe --kernel lyra2z -o stratum+tcp://us-east.zcoin.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I 19 -w 64 -g 4
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Vertcoin Miner
::
:vtc1
ECHO Vertcoin CCMiner YIIMP - Nvidia Only - Vertcoin to Miningpoolhub
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a Lyra2rev2  -o stratum+tcp://hub.miningpoolhub.com:20507 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%

::
:: ZENCoin Miners
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
ECHO ZENCoin Claymore - ZENCash to HODLPool - AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool stratum+tcp://mining.hodlpool.com:3032 -zwal %MINER_WEBLOGIN%.%MINER_NAME% -zpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen4
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCash to HODLPool
Miners\DSTM_zm_0.5.4_win\zm.exe --dev --server mining.hodlpool.com --port 3032 --user %ZEN_WALLET_ADDRESS% --pass %WORKER_PASSWORD% 
if %ERRORLEVEL% NEQ 0 goto exit
ECHO Error while running miner
pause
::
:: Pirl Miners
::
:pirl1
ECHO AMD and NVIDIA Claymore - Pirl LESS THAN 100 MH/s Only minerpool.net
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://pirl.minerpool.net:8002 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pirl2
ECHO AMD and NVIDIA Claymore - Pirl 100 MH/s to 800 MH/s Only minerpool.net
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://pirl.minerpool.net:8004 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:pirl3
ECHO AMD and NVIDIA Claymore - Pirl MORE THAN 800 MH/s Only minerpool.net
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://pirl.minerpool.net:8044 -ewal %PIRL_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ellaism Miners
::

:ella1
ECHO AMD and NVIDIA Claymore - Ella LESS THAN 180 MH/s ellaismpool America Based
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ellaismpool.com:8008 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella2
ECHO AMD and NVIDIA Claymore - Ella 100 MH/s to 800 MH/s ellaismpool America Based
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ellaismpool.com:8004 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella3
ECHO AMD and NVIDIA Claymore - Ella MORE THAN 800 MH/s ellaismpool America Based
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ellaismpool.com:8009 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella4
ECHO AMD and NVIDIA Claymore - Ella LESS THAN 180 MH/s cryptobitpool.eu Europe Based
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ella.cryptobitpool.eu:8002 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella5
ECHO AMD and NVIDIA Claymore - Ella 100 MH/s to 800 MH/s cryptobitpool.eu Europe Based
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ella.cryptobitpool.eu:8003 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ella6
ECHO AMD and NVIDIA Claymore - Ella MORE THAN 800 MH/s cryptobitpool.eu Europe Based
Miners\Claymore_Dual_Ethereum_v10.2\EthDcrMiner64.exe -epool stratum+tcp://ella.cryptobitpool.eu:8004 -ewal %ELLA_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Sumokoin Miners
::

:sumo1
ECHO CAST VEGA Miner - Sumo to easyhash.io - Mining Rig Difficulty for RX VEGA
Miners\cast_xmr-vega-win64_070\cast_xmr-vega -S sumo.easyhash.io:3332 -u %SUMO_WALLET_ADDRESS%.%MINER_NAME% %*
if %ERRORLEVEL% NEQ 0 goto exit
pause

:sumo2
ECHO Claymore CryptoNote 9.7 AMD Only - Sumo to easyhash.io - Mining Rig Difficulty - For R9 / RX Series
Miners\Claymore_CryptoNote_GPU_Miner_v9.7\NsGpuCNMiner.exe -o stratum+tcp://sumo.easyhash.io:3332 -u %SUMO_WALLET_ADDRESS% -p %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:sumo3
ECHO Claymore CryptoNote 10.2 AMD Only - Sumo to easyhash.io - Mining Rig Difficulty - For VEGA
Miners\Claymore_CryptoNote_AMDv10.2\NsGpuCNMiner.exe -xpool stratum+tcp://sumo.easyhash.io:3332 -xwal %SUMO_WALLET_ADDRESS% -xpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Karbowanec Miners
::

:krb1
ECHO CAST VEGA Miner - Karbowanec to easyhash.io - Mining Rig Difficulty for RX VEGA
Miners\cast_xmr-vega-win64_070\cast_xmr-vega -S krb.easyhash.io:3532 -u %KRB_WALLET_ADDRESS%.%MINER_NAME% %*
if %ERRORLEVEL% NEQ 0 goto exit
pause

:krb2
ECHO Claymore CryptoNote 9.7 AMD Only - Karbowanec to easyhash.io - Mining Rig Difficulty - For R9 / RX Series
Miners\Claymore_CryptoNote_GPU_Miner_v9.7\NsGpuCNMiner.exe -o stratum+tcp://krb.easyhash.io:3532 -u %KRB_WALLET_ADDRESS% -p %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:krb3
ECHO Claymore CryptoNote 10.2 AMD Only - Karbowanec to easyhash.io - Mining Rig Difficulty - For VEGA
Miners\Claymore_CryptoNote_AMDv10.2\NsGpuCNMiner.exe -xpool stratum+tcp://krb.easyhash.io:3532 -xwal %KRB_WALLET_ADDRESS% -xpsw %WORKER_PASSWORD% -allpools 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: ZCash Miners Pt2
::

:zcash4
ECHO AMD ZCash Claymore - Zcash to HODLPool AMD Only
Miners\Claymore_ZCash_AMD_GPU_Miner_v12.6\ZecMiner64.exe -zpool stratum+tcp://mining.hodlpool.com:3033 -zwal %ZCASH_WALLET_ADDRESS%.%MINER_NAME%/%EMAIL_ADDRESS% -zpsw %WORKER_PASSWORD% -ftime 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zcash5
ECHO NVIDIA EWBF's CUDA Zcash Miner - Zcash to HODLPool NVIDIA Only
Miners\ZEC_M0.3.4b\miner --server mining.hodlpool.com --user %ZCASH_WALLET_ADDRESS%.%MINER_NAME%.%EMAIL_ADDRESS% --pass %WORKER_PASSWORD% --port 3033 --zec
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: MonaCoin Miners
::
:mona1
ECHO CCMiner YIIMP - Nvidia Only - Monacoin to Miningpoolhub
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a lyra2z -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:mona2
ECHO SGMiner - AMD Only - Monacoin to Miningpoolhub
Miners\sgminer_5_4_0-lbry\sgminer.exe --kernel lyra2z -o stratum+tcp://hub.miningpoolhub.com:20593 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD% -I 19 -w 64 -g 4
if %ERRORLEVEL% NEQ 0 goto exit
pause

:EOF
