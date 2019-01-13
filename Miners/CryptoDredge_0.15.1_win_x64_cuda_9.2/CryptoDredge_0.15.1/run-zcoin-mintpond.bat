@echo off
title MTP (XZC) - mintpond pool
:loop
  CryptoDredge -a mtp -o stratum+tcp://zcoin.mintpond.com:3000 -u a2VcGTRJ8g5NAWQ1pxYUcUVyHpWA2k9BEx.benchmark -p x
goto loop
pause
